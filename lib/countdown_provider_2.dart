import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/services.dart';

final countdownProvider2 =
    ChangeNotifierProvider((ref) => CountdownProvider2());

class CountdownProvider2 extends ChangeNotifier {
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
  StreamSubscription<OnConnectionStateChangedEvent>? subscriptionStateConection;
  String estadoRespaldo = '';
  bool isRunningRespaldo = false;

  void volver(bool volvio) {
    volvioDeTimerZapperScreen = volvio;
  }

  void startStopTimer(String modoTiempo, Device _device, TerapiaTotal _terapia,
      bool playInicial) async {
    device = _device;
    //device = await Services().getDevice(_device.mac);
    subscriptionStateConection?.cancel();
    subscriptionStateConection = BleServices().conectionState.listen((event) {
      if (event.connectionState == BluetoothConnectionState.disconnected &&
          event.device.remoteId.toString() == device.mac) {
        _tickSubscription?.pause();
        device.conectado = false;
        Services().editDevice(device);
        if (isRunning) {
          isRunningRespaldo = isRunning;
          isRunning = false;
        }
        if (estado != 'Desconectado') {
          estadoRespaldo = estado;
          estado = 'Desconectado';
        }
        //ToDo: Inhabilitar el boton play/pause y volver
        //TODO: enviar comandos bluetooth correspondiente al equipo
        showNotification(device.nombre,
            'El dispositivo ${device.nombre} perdió la conexón Bluetooth.');

        BleServices().reConectar(event.device);

        notifyListeners();
        print(
            '********>> isRunning es $isRunning >>> isRunningRespaldo es $isRunningRespaldo >>>> Estado es $estado >>> EstadoRespaldo es $estadoRespaldo');
      }
      if (event.connectionState == BluetoothConnectionState.connected &&
          event.device.remoteId.toString() == device.mac) {
        device.conectado = true;
        Services().editDevice(device);
        if (isRunningRespaldo) {
          _startTimer(duration.inSeconds);
          isRunning = true;
          isRunningRespaldo = false;
        }
        estado = estadoRespaldo;
        showNotification(device.nombre,
            'El dispositivo ${device.nombre} fue reconectado al Bluetooth.');
        //ToDo: Habilitar el boton play/pause y volver
        //TODO: enviar comandos bluetooth correspondiente al equipo
        notifyListeners();
        print(
            '>>>>>>>> isRunning es $isRunning >>> isRunningRespaldo es $isRunningRespaldo >>>> Estado es $estado >>> EstadoRespaldo es $estadoRespaldo');
      }
    });

    if (device.conectado) {
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
    }
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
    subscriptionStateConection?.cancel();
    showNotification(device.nombre, 'La terapia ha terminado con éxito');
    isRunning = false;
    estado = 'FIN';
    ciclos = 1;
    volvioDeTimerZapperScreen = true;
    await BleServices()
        .enviarDataBLE(device.mac, listComandos['fin']!, terapia);
    notifyListeners();
  }
}
