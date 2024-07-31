import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void volver(bool volvio) {
    volvioDeTimerZapperScreen = volvio;
  }

  void startStopTimer(String modoTiempo) {
    modo = modoTiempo;
    if (modoTiempo == 'Modo A' && duration.inSeconds == 0) {
      duration = tiempoModoA;
      estado = 'Ciclo 1';
    } else if (duration.inSeconds == 0) {
      duration = tiempoModoB;
      estado = 'Ciclo Unico';
    }
    if (!isRunning) {
      _startTimer(duration.inSeconds);
    } else {
      _tickSubscription?.pause();
    }
    isRunning = !isRunning;
    notifyListeners();
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
        } else if (ciclos == 2) {
          estado = 'Reposo 1';
          setCountdownDuration(tiempoReposo);
        } else if (ciclos == 3) {
          estado = 'Ciclo 2';
          setCountdownDuration(tiempoModoA);
        } else if (ciclos == 4) {
          estado = 'Reposo 2';
          setCountdownDuration(tiempoReposo);
        } else if (ciclos == 5) {
          estado = 'Ciclo 3';
          setCountdownDuration(tiempoModoA);
        } else {
          estado = 'FIN';
          ciclos = 1;
          _tickSubscription?.cancel();
          isRunning = false;
          showNotification();
        }
      } else if (modo == 'Modo B') {
        if (duration.inSeconds == 0) {
          estado = 'FIN';
          ciclos = 1;
          _tickSubscription?.cancel();
          isRunning = false;
          showNotification();
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

  void terminarTimer() {
    _tickSubscription?.cancel();
    isRunning = false;
    estado = 'Ciclo Unico';
    ciclos = 1;
    modo = 'Modo B';
    duration = const Duration(seconds: 0);
    volvioDeTimerZapperScreen = true;
    notifyListeners();
  }
}
