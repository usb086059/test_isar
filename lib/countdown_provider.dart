import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/backup_comando.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/services.dart';

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
  StreamSubscription<OnConnectionStateChangedEvent>? subscriptionStateConection;
  String estadoRespaldo = '';
  bool isRunningRespaldo = false;
  //List<BackupComando> listBackupComando = [];
  BluetoothDevice myBlue =
      BluetoothDevice(remoteId: const DeviceIdentifier("str"));
  int myRSSI = 0;
  bool equipoConectado = false;
  String backUpComando = '';

  BluetoothCharacteristic caracteristica = BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('str'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1'));

  //bool bussy = false;

  void volver(bool volvio) {
    volvioDeTimerZapperScreen = volvio;
  }

  void avisoDesconexion() {
    print('****************************** AvisoDesconexion');
    _tickSubscription?.cancel();
    device.conectado = false;
    equipoConectado = device.conectado;
    Services().editDevice(device);
    if (isRunning) {
      isRunningRespaldo = isRunning;
      isRunning = false;
    }
    if (estado != 'Desconectado') {
      estadoRespaldo = estado;
      estado = 'Desconectado';
    }
    showNotification(device.nombre,
        'El dispositivo ${device.nombre} perdió la conexón Bluetooth.');
  }

  void avisoReconexion() {
    device.conectado = true;
    equipoConectado = device.conectado;
    Services().editDevice(device);
    if (isRunningRespaldo) {
      _startTimer(duration.inSeconds);
      isRunning = true;
      isRunningRespaldo = false;
    }
    estado = estadoRespaldo;
    showNotification(device.nombre,
        'El dispositivo ${device.nombre} fue reconectado al Bluetooth.');
  }

  void startStopTimer(String modoTiempo, Device _device, TerapiaTotal _terapia,
      bool playInicial) async {
    device = _device;
    equipoConectado = device.conectado;
    subscriptionStateConection?.cancel();
    subscriptionStateConection =
        BleServices().conectionState.listen((event) async {
      if (event.connectionState == BluetoothConnectionState.disconnected &&
          event.device.remoteId.toString() == device.mac) {
        avisoDesconexion();
        if (!event.device.isAutoConnectEnabled) {
          await BleServices().reConectar(event.device);
        }
        notifyListeners();
      }
      if (event.connectionState == BluetoothConnectionState.connected &&
          event.device.remoteId.toString() == device.mac) {
        print('*****${BleServices().elbus}');
        if (!BleServices().elbus) {
          print(
              '********************************** AVISO DE RECONEXION **************');
          await BleServices().descubrirServicios(event.device);
          if (backUpComando.isNotEmpty) {
            enviarComando(backUpComando);
          }
          avisoReconexion();
          notifyListeners();
        }
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
    print(BleServices().elbus);
    backUpComando = comando;
    print(
        '**************************************************** bacupComando ********* $backUpComando');
    if (!BleServices().elbus) {
      final bool enviado = await BleServices()
          .enviarDataBLE(device.mac, listComandos[comando]!, terapia);
      //await Future.delayed(const Duration(milliseconds: 100));

      if (enviado) {
        backUpComando = '';
        //subscriptionStateConection?.resume();
        print(
            '*********************************************** COMANDO ENVIADO y Subscription Resume() ************');
        //bussy = false;
      } else {
        //ToDo: Avisar que no se envió el comando correctacmente e intentar reenviar hasta que se haga correctamente
        print(
            '*********************************************** No hubo respuesta');
        //subscriptionStateConection?.resume();
        //bussy = false;
      }
    }
  }

  void _startTimer(int seconds) async {
    _tickSubscription?.cancel();
    _tickSubscription = Stream<int>.periodic(
            const Duration(seconds: 1), (sec) => seconds - sec - 1)
        .take(seconds)
        .listen((timeLeftInSeconds) async {
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

  BluetoothCharacteristic get getCaracteristica {
    print(
        '**************************************  ****************** $caracteristica');
    return caracteristica;
  }

  /* set setBussy(bool value) {
    bussy = value;
    print(bussy);
  } */

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
