import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/ble_services.dart';

final countdownProvider = ChangeNotifierProvider((ref) => CountdownProvider());

class CountdownProvider extends ChangeNotifier {
  Duration duration = const Duration(seconds: 0);
  Duration tiempoModoA = const Duration(seconds: 10);
  Duration tiempoModoB = const Duration(seconds: 6);
  Duration tiempoReposo = const Duration(seconds: 12);
  int ciclos = 1;
  String estado = 'Ciclo Unico';
  bool isRunning = false;
  String modo = 'Modo B';
  StreamSubscription<int>? _tickSubscription;
  bool volvioDeTimerZapperScreen = false;
  Device device =
      Device(tipo: '', mac: '', nombre: '', conectado: false, relojAsignado: 0);
  TerapiaTotal terapia = TerapiaTotal(
      nombre: '',
      frecMin: 1,
      frecMax: 1,
      info: 'Agregue una breve descripción de la terapia',
      editable: false,
      idTerapiaPersonal: 0);

  void volver(bool volvio) {
    volvioDeTimerZapperScreen = volvio;
  }

  void startStopTimer(String modoTiempo, Device _device, TerapiaTotal _terapia,
      bool playInicial) {
    if (playInicial) {
      _tickSubscription?.cancel();
      ciclos = 1;
      isRunning = false;
      modo = modoTiempo;
      device = _device;
      terapia = _terapia;
      if (modoTiempo == 'Modo A') {
        duration = tiempoModoA;
        estado = 'Ciclo 1';
      } else {
        duration = tiempoModoB;
        estado = 'Ciclo Unico';
      }
    }

    if (!isRunning) {
      _startTimer(duration.inSeconds);
    } else {
      _tickSubscription?.pause();
    }
    isRunning = !isRunning;
    notifyListeners();
  }

  void enviarComando(String comando) async {
    await BleServices()
        .enviarDataBLE(device.mac, listComandos[comando]!, terapia);
  }

  void _startTimer(int seconds) {
    _tickSubscription?.cancel();
    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) {
      duration = Duration(seconds: timeLeftInSeconds);
      if (modo == 'Modo A' && duration.inSeconds == 0) {
        ciclos++;
        if (ciclos == 1) {
          estado = 'Ciclo 1';
          enviarComando('play');
        } else if (ciclos == 2) {
          estado = 'Reposo 1';
          enviarComando('pause');
          setCountdownDuration(tiempoReposo);
        } else if (ciclos == 3) {
          estado = 'Ciclo 2';
          enviarComando('play');
          setCountdownDuration(tiempoModoA);
        } else if (ciclos == 4) {
          estado = 'Reposo 2';
          enviarComando('pause');
          setCountdownDuration(tiempoReposo);
        } else if (ciclos == 5) {
          estado = 'Ciclo 3';
          enviarComando('play');
          setCountdownDuration(tiempoModoA);
        } else {
          terminarTimer();
        }
      } else if (modo == 'Modo B') {
        if (duration.inSeconds == 0) {
          terminarTimer();
        } else {
          estado = 'Ciclo Unico';
        }
      }
      notifyListeners();
    });
  }

  Color get ciclosLeftColor {
    Color colorCiclo;
    if ((ciclos == 1 && estado != 'FIN') || ciclos == 3 || ciclos == 5) {
      colorCiclo = const Color.fromARGB(255, 52, 78, 153);
    } else {
      colorCiclo = Colors.purple;
      //colorCiclo = const Color.fromARGB(255, 142, 176, 219);
      //colorCiclo = const Color.fromARGB(255, 189, 194, 238);
    }
    return colorCiclo;
  }

  String get timeLeftString {
    final minutes =
        ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds =
        (duration.inSeconds % 60).floor().toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void setCountdownDuration(Duration newDuration) {
    duration = newDuration;
    _tickSubscription?.cancel();
    isRunning = true;
    _startTimer(duration.inSeconds);
  }

  void terminarTimer() async {
    _tickSubscription?.cancel();
    showNotification(device.nombre);
    isRunning = false;
    estado = 'FIN';
    ciclos = 1;
    volvioDeTimerZapperScreen = true;
    await BleServices()
        .enviarDataBLE(device.mac, listComandos['fin']!, terapia);
    notifyListeners();
  }
}
