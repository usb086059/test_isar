//import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/battery_levels.dart';
//import 'package:flutter_application_1/caracteristicas.dart';
import 'package:flutter_application_1/comandos.dart';
//import 'package:flutter_application_1/countdown_provider.dart';
//import 'package:flutter_application_1/device.dart';
//import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:isar/isar.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/pack_comando.dart';

final bleProvider = ChangeNotifierProvider((ref) => BleServices());

/* BluetoothCharacteristic caracteristica = BluetoothCharacteristic(
    remoteId: const DeviceIdentifier('disponible'),
    serviceUuid: Guid('FFE0'),
    characteristicUuid: Guid('FFE1')); */

bool bussy = false;

List<PackComando> commandQueue = [];
List<PackComando> listBackupCommand = [];
bool isSending = false;

/* ************************************** */
List<BluetoothCharacteristic> listCaracteristicas = [
  BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('disponible'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1')),
  BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('disponible'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1')),
  BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('disponible'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1')),
  BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('disponible'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1')),
  BluetoothCharacteristic(
      remoteId: const DeviceIdentifier('disponible'),
      serviceUuid: Guid('FFE0'),
      characteristicUuid: Guid('FFE1')),
];
List<List<int>> respuestas = [
  [],
  [],
  [],
  [],
  [],
];
int caseNumber = 0;
bool deviceDisconnected = false;
StreamSubscription<List<int>>? subscriptionCaracteristica0;
StreamSubscription<List<int>>? subscriptionCaracteristica1;
StreamSubscription<List<int>>? subscriptionCaracteristica2;
StreamSubscription<List<int>>? subscriptionCaracteristica3;
StreamSubscription<List<int>>? subscriptionCaracteristica4;
String bateriaxxx = batteryLevels[1];

/* ***************************************** */

class BleServices extends ChangeNotifier {
  BleServices() {
    print('****************** Constructor de BleServices llamado');
  }
  //StreamSubscription<List<int>>? subscriptionCaracteristica;
  List<String> bleServicesBatery = [
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
  ];
  bool get isBussy {
    return bussy;
  }

  List<BluetoothCharacteristic> get getListCaracteristicas {
    return listCaracteristicas;
  }

  /*  set setBleservicesBatery(String valor) {
    bleServicesBatery = valor;
    notifyListeners();
  } */

  String getBatteryLevelForBlescreen(String remoteId) {
    for (int i = 0; i < 5; i++) {
      if (listCaracteristicas[i].remoteId.toString() == remoteId) {
        return bleServicesBatery[i];
      }
    }
    return bleServicesBatery[5];
  }
  /*  String get getBleservicesBatery {
    return bleServicesBatery;
  } */

  List<PackComando> get getListBackupComando {
    return listBackupCommand;
  }

  Future<bool> bleState() async {
    //bool bluetoothState = false;
    // handle bluetooth on & off
// note: for iOS the initial state is typically BluetoothAdapterState.unknown
// note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
    /* StreamSubscription<BluetoothAdapterState> subscription = FlutterBluePlus
        .adapterState
        .listen((BluetoothAdapterState state) async {
      print('>>>>>>>>>>>>>>>>$state');

      if (state == BluetoothAdapterState.on) {
        // usually start scanning, connecting, etc
        //await scanDevices();
        bluetoothState = true;
      } else {
        // show an error to the user, etc
        //await bleTurnOn();
        //await scanDevices();
        bluetoothState = false;
      }
    });
    subscription.cancel(); */
    if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) {
      return true;
    } else {
      return false;
    }
    //return bluetoothState;
  }

  Future<void> bleTurnOn() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  Future<List<BluetoothDevice>> scanDevicesConected() async {
    final List<BluetoothDevice> listDevicesConected =
        FlutterBluePlus.connectedDevices;
    return FlutterBluePlus.connectedDevices;
  }

  Future<void> scanDevices(int segundos) async {
// Wait for Bluetooth enabled & permission granted
// In your real app you should use `FlutterBluePlus.adapterState.listen` to handle all states
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    FlutterBluePlus.stopScan();

    await FlutterBluePlus.startScan(timeout: Duration(seconds: segundos));
    //withKeywords: ['SH'], timeout: const Duration(seconds: 15));

// wait for scanning to stop
    await FlutterBluePlus.isScanning.where((val) => val == false).first;

    //FlutterBluePlus.stopScan();
  }

  Stream<OnConnectionStateChangedEvent> get conectionState =>
      FlutterBluePlus.events.onConnectionStateChanged;

  /* void startss(){
      conectionState.listen((event) { 
        if(event.connectionState == BluetoothConnectionState.connected){
          print('>>>>>>>>>>>Device conected: ${event.device}');
        }
      });
    } */

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  /* @override
  notifyListeners(); */

  /* Future<void> conectar(BluetoothDevice device) async {
    var subscription = device.connectionState.listen((BluetoothConnectionState state) async {
      if(state == BluetoothConnectionState.disconnected){
        await device.connect();
      } else {
        await device.cancelWhenDisconnected(subscription, delayed: true, next: true);
      }
     });
  } */

  Stream<List<BluetoothDevice>> get devicesConected {
    StreamController<List<BluetoothDevice>> controller =
        StreamController<List<BluetoothDevice>>();
    controller.add(FlutterBluePlus.connectedDevices);
    return controller.stream;
  }

  Future<bool> reConectar(BluetoothDevice device) async {
    if (await bleState()) {
      //int count = 0;
      try {
        await device.connect(
            autoConnect: true, mtu: null, timeout: const Duration(seconds: 5));
        return true;
        /* await device.connectionState
        .where((event) => event == BluetoothConnectionState.connected)
        .first; */
      } catch (e) {
        showNotification(device.advName, 'se acabo el timeout');
        return false;
      }
    } else {
      await device.disconnect();
      showNotification(device.advName,
          'El Bluetooth de su telefono esta apagado. Enciendalo y reconecte el ${device.advName} manualmente');
      return false;
    }
  }

  Future<void> conectar(BluetoothDevice device) async {
    if (await bleState()) {
      FlutterBluePlus.stopScan();
      await device.connect();
      /* await device.connectionState
          .where((event) => event == BluetoothConnectionState.connected)
          .first; */
      if (device.isConnected) {
        await scanDevices(0);
        await descubrirServicios(device);
      }
    } else {
      await bleTurnOn();
      await device.connect();
      if (device.isConnected) {
        await scanDevices(0);
        await descubrirServicios(device);
        //await Future.delayed(const Duration(seconds: 3));
      }
    }
    /* _pulso?.cancel();
    _pulso = Stream<int>.periodic(const Duration(seconds: 3), (sec) => sec)
        .listen((event) async {
      notifyListeners();
      print('******** PeriodicBleServices: ${event}');
    }); */

    /* int elMTU = await device.requestMtu(512);
    await Future.delayed(const Duration(seconds: 16));
    print('>>>>>>>>>> El MTU negociaodo es: $elMTU'); */
    notifyListeners();
  }

  /*  set setCaracteristica(BluetoothCharacteristic _caracteristica) {
    caracteristica = _caracteristica;
  } */

  void escuchas() {
    switch (caseNumber) {
      case 0:
        subscriptionCaracteristica0?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica0 =
              listCaracteristicas[0].onValueReceived.listen((event) async {
            if (!String.fromCharCodes(event).contains('*')) {
              respuestas[0].clear();
            }
            respuestas[0].clear();
            respuestas[0].addAll(event);
            List<String> listString =
                String.fromCharCodes(respuestas[0]).split('*');
            listString.removeLast();
            for (String element in listString) {
              final int? batteryLevel = int.tryParse(element);
              if (batteryLevel != null) {
                print('**************** batteryLevel: $batteryLevel');
                bleServicesBatery[0] = selectBatteryLevelImage(batteryLevel);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[0])}');
            print('************* respuesta BOTON: ${listString}');
            notifyListeners();
          });
        }
        break;
      case 1:
        subscriptionCaracteristica1?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica1 =
              listCaracteristicas[1].onValueReceived.listen((event) {
            if (!String.fromCharCodes(event).contains('*')) {
              respuestas[1].clear();
            }
            respuestas[1].clear();
            respuestas[1].addAll(event);
            List<String> listString1 =
                String.fromCharCodes(respuestas[1]).split('*');
            listString1.removeLast();
            for (String element in listString1) {
              final int? batteryLevel1 = int.tryParse(element);
              if (batteryLevel1 != null) {
                print('**************** batteryLevel 1: $batteryLevel1');
                bleServicesBatery[1] = selectBatteryLevelImage(batteryLevel1);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[1])}');
            print('************* respuesta BOTON: ${listString1}');
            notifyListeners();
          });
        }
      case 2:
        subscriptionCaracteristica2?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica2 =
              listCaracteristicas[caseNumber].onValueReceived.listen((event) {
            respuestas[caseNumber].clear();
            respuestas[caseNumber].addAll(event);
          });
        }
      case 3:
        subscriptionCaracteristica3?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica3 =
              listCaracteristicas[caseNumber].onValueReceived.listen((event) {
            respuestas[caseNumber].clear();
            respuestas[caseNumber].addAll(event);
          });
        }
      case 4:
        subscriptionCaracteristica4?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica4 =
              listCaracteristicas[caseNumber].onValueReceived.listen((event) {
            respuestas[caseNumber].clear();
            respuestas[caseNumber].addAll(event);
          });
        }
    }
  }

  Future<void> caracteristicas(
      BluetoothDevice device, bool disconnected) async {
    deviceDisconnected = disconnected;
    if (disconnected) {
      for (int i = 0; i < 5; i++) {
        if (listCaracteristicas[i].remoteId == device.remoteId) {
          listCaracteristicas[i] = BluetoothCharacteristic(
              remoteId: const DeviceIdentifier('disponible'),
              serviceUuid: Guid('FFE0'),
              characteristicUuid: Guid('FFE1'));
          caseNumber = i;
          escuchas();
          i = 5;
        }
      }
      //return;
    } else {
      bool characteristicExist = false;
      for (int i = 0; i < 5; i++) {
        if (listCaracteristicas[i].remoteId == device.remoteId) {
          characteristicExist = true;
          i = 5;
        }
      }
      if (!characteristicExist) {
        BluetoothCharacteristic caracteristicaBase = BluetoothCharacteristic(
            remoteId: device.remoteId,
            serviceUuid: Guid('FFE0'),
            characteristicUuid: Guid('FFE1'));
        await caracteristicaBase.setNotifyValue(true);
        for (int i = 0; i < 5; i++) {
          if (listCaracteristicas[i].remoteId.toString() == 'disponible') {
            listCaracteristicas[i] = caracteristicaBase;
            caseNumber = i;
            print('*********************** caseNumber: $caseNumber');
            escuchas();
            i = 5;
          }
        }
        //return;
      }
    }
    return;
  }

  Future<void> descubrirServicios(BluetoothDevice device) async {
    List<BluetoothService> listServicios = await device.discoverServices();
    print('******** Servicios: ${listServicios.length}');
    /* caracteristica = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));
    await caracteristica.setNotifyValue(true); */
    await caracteristicas(device, false);

    print('**************** BleServicesBattery: $bleServicesBatery');
    await Future.delayed(const Duration(seconds: 1));
    await sendCommand(PackComando(
        deviceMac: device.remoteId.toString(),
        comando: '*', //solo para activar el envio de nivel de bateria
        terapia: TerapiaTotal(
            nombre: '',
            frecMin: 1,
            frecMax: 1,
            info: 'Agregue una breve descripción de la terapia',
            editable: false,
            idTerapiaPersonal: 0)));
    notifyListeners();
  }

  /* BluetoothCharacteristic get gCaracteristica {
    return caracteristica;
  } */

  Future<void> desconectar(BluetoothDevice device) async {
    FlutterBluePlus.stopScan();
    await device.disconnect();
    await scanDevices(0);
    notifyListeners();
  }

  Future<void> desconectar2(String reomteId) async {
    if (await bleState()) {
      FlutterBluePlus.stopScan();
      final BluetoothDevice device = FlutterBluePlus.connectedDevices
          .firstWhere((element) => element.remoteId.toString() == reomteId);
      print('************** Device **** $device');
      await device.disconnect();
      await scanDevices(0);
    } else {
      await bleTurnOn();
      final BluetoothDevice device = FlutterBluePlus.connectedDevices
          .firstWhere((element) => element.remoteId.toString() == reomteId);
      await device.disconnect();
      await scanDevices(0);
    }
    notifyListeners();
  }

  Future<void> processShipmentCommand() async {
    isSending = true;
    while (commandQueue.isNotEmpty) {
      PackComando packCommandFirst = commandQueue.first;
      if (!bussy) {
        packCommandFirst.enviado = await enviarDataBLE(
            packCommandFirst.deviceMac,
            packCommandFirst.comando,
            packCommandFirst.terapia);
        print('**************** termino enviarDataTable');
        commandQueue.removeAt(0);
        if (!packCommandFirst.enviado) {
          listBackupCommand.add(packCommandFirst);
          print('**************** no se envio el comando');
          print(
              '**************** listBackupCommand => ${listBackupCommand.length}');
          //ToDo: Avisar que no se envió el comando o determinar...
          //todo: ... un metodo para evitar que el While se pegue
        }
      }
    }
    isSending = false;
    print('**************** termino el bucle While');
  }

  Future<void> sendCommand(PackComando packComando) async {
    commandQueue.add(packComando);
    if (!isSending) {
      processShipmentCommand();
    }
  }

  Future<bool> enviarDataBLE(
      String remoteId, String comando, TerapiaTotal terapia) async {
    BluetoothDevice device = BluetoothDevice.fromId(remoteId);
    int indiceRespuesta = listCaracteristicas
        .indexWhere((element) => element.remoteId == device.remoteId);
    bussy = true;

    if (comando == listComandos['ON']! && terapia.frecMin == terapia.frecMax) {
      comando = '${listComandos['fija']!}$comando';
    }
    String frecMin = '${listComandos['Fmin']!}${terapia.frecMin.toString()}*';
    String frecMax = '${listComandos['Fmax']!}${terapia.frecMax.toString()}*';

    try {
      device = FlutterBluePlus.connectedDevices
          .firstWhere((element) => element.remoteId.toString() == remoteId);
    } catch (e) {
      print('***************** ERROR: el equipo esta desconectado');
    }

    /* List<BluetoothService> listServicios = await device.discoverServices();

    final caracteristica = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));

    await caracteristica.setNotifyValue(true); */
    //List<int> respuesta = [];
    print(
        '********************************* respuesta *************** ${String.fromCharCodes(respuestas[indiceRespuesta])}');
    /* subscriptionCaracteristica?.cancel();
    subscriptionCaracteristica = caracteristica.onValueReceived.listen((event) {
      respuesta.clear();
      respuesta.addAll(event);
      //subscriptionCaracteristica?.cancel();
      print(
          '*************************************** este es event ${event} ***');
    }); */

    print(
        '********************NotifyValue ************** ${listCaracteristicas[indiceRespuesta].isNotifying}');

    const int delayEntreEnviosPaquete = 30;

    if (comando.contains(listComandos['ON']!)) {
      for (int i = 1; i <= frecMin.length; i++) {
        await listCaracteristicas[indiceRespuesta].write(
            frecMin.substring(i - 1, i).codeUnits,
            withoutResponse: true);
        await Future.delayed(
            const Duration(milliseconds: delayEntreEnviosPaquete));
      }
      await Future.delayed(const Duration(milliseconds: 200));
      if (String.fromCharCodes(respuestas[indiceRespuesta]).contains(frecMin)) {
        //respuesta.clear();
        for (int i = 1; i <= frecMax.length; i++) {
          await listCaracteristicas[indiceRespuesta].write(
              frecMax.substring(i - 1, i).codeUnits,
              withoutResponse: true);
          await Future.delayed(
              const Duration(milliseconds: delayEntreEnviosPaquete));
        }
        await Future.delayed(const Duration(milliseconds: 200));
        if (String.fromCharCodes(respuestas[indiceRespuesta])
            .contains(frecMax)) {
          //respuesta.clear();
        } else {
          /* subscriptionCaracteristica?.cancel();
          device.cancelWhenDisconnected(subscriptionCaracteristica!); */
          return false;
        }
      } else {
        /* subscriptionCaracteristica?.cancel();
        device.cancelWhenDisconnected(subscriptionCaracteristica!); */
        return false; //comandoEnviado;
      }
    }

    for (int i = 1; i <= comando.length; i++) {
      await listCaracteristicas[indiceRespuesta]
          .write(comando.substring(i - 1, i).codeUnits, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      print(
          '**********comando: $comando  <> *********************** i del for comando: $i');
    }
    await Future.delayed(const Duration(milliseconds: 200));
    print(
        '********************************* respuesta DESPUES DEL FOR: ${String.fromCharCodes(respuestas[indiceRespuesta])}');
    if (String.fromCharCodes(respuestas[indiceRespuesta]).contains(comando)) {
      //respuesta.clear();
      /* subscriptionCaracteristica?.cancel();
      device.cancelWhenDisconnected(subscriptionCaracteristica!); */
      print('>>>>>>>>>>$frecMin');
      print('>>>>>>>>>>$frecMax');
      print('>>>>>>>>>>$comando');
      //CountdownProvider().setBussy = false;
      bussy = false;
      return true;
    } else {
      //respuesta.clear();
      /* subscriptionCaracteristica?.cancel();
      device.cancelWhenDisconnected(subscriptionCaracteristica!); */
      //CountdownProvider().setBussy = false;
      bussy = false;
      return false;
    }
    /* print(
        'lenght: ${respuesta.length} -- Valores: ${String.fromCharCodes(respuesta)}');
    subscriptionCaracteristica.cancel(); */
  }
}
