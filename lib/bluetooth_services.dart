import 'dart:async';
import 'dart:io';

import 'package:flutter_application_1/battery_levels.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/pack_comando.dart';
import 'package:flutter_application_1/serialize.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

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
List<String> listCaracteristicasRemoteId = [
  'disponible',
  'disponible',
  'disponible',
  'disponible',
  'disponible'
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
//String bateriaxxx = batteryLevels[1];

/* ***************************************** */

class BluetoothServices {
  BluetoothServices() {
    print('**************** Constructor de BluetoothServices llamado');
  }
  List<String> bleServicesBatery = [
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
    batteryLevels[0],
  ];
  List<String> bleServicesBateryAzul = [
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

  Device devForScannedDevices = Device(
      tipo: 'tipo',
      mac: 'mac',
      nombre: 'nombre',
      conectado: false,
      relojAsignado: 0);

  void setDevForScannedDevices(Map<String, dynamic> dev) {
    devForScannedDevices = deSerializeDevice(dev);
  }

  String getBatteryLevel(String remoteId) {
    for (int i = 0; i < 5; i++) {
      if (listCaracteristicas[i].remoteId.toString() == remoteId) {
        return bleServicesBatery[i];
      }
    }
    return bleServicesBatery[5];
  }

  String getBatteryLevelAzul(String remoteId) {
    for (int i = 0; i < 5; i++) {
      if (listCaracteristicas[i].remoteId.toString() == remoteId) {
        return bleServicesBateryAzul[i];
      }
    }
    return bleServicesBatery[5];
  }

  List<PackComando> get getListBackupComando {
    return listBackupCommand;
  }

  Future<bool> bleState() async {
    if (FlutterBluePlus.adapterStateNow == BluetoothAdapterState.on) {
      return true;
    } else {
      return false;
    }
    //return bluetoothState;
  }

  Future<void> bleTurnOn() async {
    //await FlutterBluePlus.turnOn();
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

    final List<Device> lastScannedDevices = await getLastScannedDevices();
    final Map<String, dynamic> data = {
      'command': 'updateScannedDevices',
      'scannedDevices': serializeListDevice(lastScannedDevices)
    };
    FlutterForegroundTask.sendDataToMain(data);
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Future<List<Device>> getLastScannedDevices() async {
    List<Device> lastScannedDevices = [];
    final List<ScanResult> lastScanResults = FlutterBluePlus.lastScanResults;
    if (lastScanResults.isNotEmpty) {
      for (ScanResult element in lastScanResults) {
        final Map<String, dynamic> data = {
          'command': 'getDeviceForScanResult',
          'deviceId': element.device.remoteId.toString()
        };
        FlutterForegroundTask.sendDataToMain(data);
        await Future.delayed(const Duration(milliseconds: 100));
        if (devForScannedDevices.nombre == 'nombre') {
          lastScannedDevices.add(Device(
              tipo: element.device.advName,
              mac: element.device.remoteId.toString(),
              nombre: 'Sin nombre',
              conectado: false,
              relojAsignado: 0));
        } else {
          lastScannedDevices.add(devForScannedDevices);
        }
      }
    }
    return lastScannedDevices;
  }

  Stream<OnConnectionStateChangedEvent> get conectionState =>
      FlutterBluePlus.events.onConnectionStateChanged;

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
        await showNotification(device.advName, 'se acabo el timeout');
        return false;
      }
    } else {
      await device.disconnect();
      await showNotification(device.advName,
          'El Bluetooth de su telefono esta apagado. Enciendalo y reconecte el ${device.advName} manualmente');
      return false;
    }
  }

  Future<void> conectar(BluetoothDevice device) async {
    try {
      print('*********** Iniciando conexión al equipo...');
      if (await bleState()) {
        await FlutterBluePlus.stopScan();
        await device.connect();
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
      // No esperes eventos aquí; el listener global debería capturarlos
      // sendPort?.send({'connectionStatus': {'id': device.remoteId.str, 'status': 'connecting'}});
    } catch (e) {
      print(
          '*********** TaskHandler: FALLÓ la llamada a connect() para ${device.remoteId}: $e');
      //sendPort?.send({'deviceConnectionState': {'id': device.remoteId.str, 'state': BluetoothConnectionState.disconnected.toString(), 'error': e.toString()}});
    }
  }

  Future<void> desconectar2(String reomteId) async {
    if (await bleState()) {
      await FlutterBluePlus.stopScan();
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
          listCaracteristicasRemoteId[i] = 'disponible';
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
            listCaracteristicasRemoteId[i] =
                caracteristicaBase.remoteId.toString();
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
                bleServicesBateryAzul[0] =
                    bleServicesBatery[0].replaceRange(20, 20, 'Azul');
                final Map<String, dynamic> data = {
                  'command': 'batteryLevel',
                  'battery': bleServicesBatery,
                  'batteryAzul': bleServicesBateryAzul,
                  'caracteristicasRemoteId': listCaracteristicasRemoteId
                };
                FlutterForegroundTask.sendDataToMain(data);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[0])}');
            print('************* respuesta BOTON: ${listString}');
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
                bleServicesBateryAzul[1] =
                    bleServicesBatery[1].replaceRange(20, 20, 'Azul');
                final Map<String, dynamic> data = {
                  'command': 'batteryLevel',
                  'battery': bleServicesBatery,
                  'batteryAzul': bleServicesBateryAzul,
                  'caracteristicasRemoteId': listCaracteristicasRemoteId
                };
                FlutterForegroundTask.sendDataToMain(data);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[1])}');
            print('************* respuesta BOTON: ${listString1}');
          });
        }
        break;
      case 2:
        subscriptionCaracteristica2?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica2 =
              listCaracteristicas[2].onValueReceived.listen((event) {
            if (!String.fromCharCodes(event).contains('*')) {
              respuestas[2].clear();
            }
            respuestas[2].clear();
            respuestas[2].addAll(event);
            List<String> listString2 =
                String.fromCharCodes(respuestas[2]).split('*');
            listString2.removeLast();
            for (String element in listString2) {
              final int? batteryLevel2 = int.tryParse(element);
              if (batteryLevel2 != null) {
                print('**************** batteryLevel 2: $batteryLevel2');
                bleServicesBatery[2] = selectBatteryLevelImage(batteryLevel2);
                bleServicesBateryAzul[2] =
                    bleServicesBatery[2].replaceRange(20, 20, 'Azul');
                final Map<String, dynamic> data = {
                  'command': 'batteryLevel',
                  'battery': bleServicesBatery,
                  'batteryAzul': bleServicesBateryAzul,
                  'caracteristicasRemoteId': listCaracteristicasRemoteId
                };
                FlutterForegroundTask.sendDataToMain(data);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[2])}');
            print('************* respuesta BOTON: ${listString2}');
          });
        }
        break;
      case 3:
        subscriptionCaracteristica3?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica3 =
              listCaracteristicas[3].onValueReceived.listen((event) {
            if (!String.fromCharCodes(event).contains('*')) {
              respuestas[3].clear();
            }
            respuestas[3].clear();
            respuestas[3].addAll(event);
            List<String> listString3 =
                String.fromCharCodes(respuestas[3]).split('*');
            listString3.removeLast();
            for (String element in listString3) {
              final int? batteryLevel3 = int.tryParse(element);
              if (batteryLevel3 != null) {
                print('**************** batteryLevel 3: $batteryLevel3');
                bleServicesBatery[3] = selectBatteryLevelImage(batteryLevel3);
                bleServicesBateryAzul[3] =
                    bleServicesBatery[3].replaceRange(20, 20, 'Azul');
                final Map<String, dynamic> data = {
                  'command': 'batteryLevel',
                  'battery': bleServicesBatery,
                  'batteryAzul': bleServicesBateryAzul,
                  'caracteristicasRemoteId': listCaracteristicasRemoteId
                };
                FlutterForegroundTask.sendDataToMain(data);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[3])}');
            print('************* respuesta BOTON: ${listString3}');
          });
        }
        break;
      case 4:
        subscriptionCaracteristica4?.cancel();
        if (!deviceDisconnected) {
          subscriptionCaracteristica4 =
              listCaracteristicas[4].onValueReceived.listen((event) {
            if (!String.fromCharCodes(event).contains('*')) {
              respuestas[4].clear();
            }
            respuestas[4].clear();
            respuestas[4].addAll(event);
            List<String> listString4 =
                String.fromCharCodes(respuestas[4]).split('*');
            listString4.removeLast();
            for (String element in listString4) {
              final int? batteryLevel4 = int.tryParse(element);
              if (batteryLevel4 != null) {
                print('**************** batteryLevel 4: $batteryLevel4');
                bleServicesBatery[4] = selectBatteryLevelImage(batteryLevel4);
                bleServicesBateryAzul[4] =
                    bleServicesBatery[4].replaceRange(20, 20, 'Azul');
                final Map<String, dynamic> data = {
                  'command': 'batteryLevel',
                  'battery': bleServicesBatery,
                  'batteryAzul': bleServicesBateryAzul,
                  'caracteristicasRemoteId': listCaracteristicasRemoteId
                };
                FlutterForegroundTask.sendDataToMain(data);
                print(
                    '**************** batteryLevelAddress: $bleServicesBatery');
              } else {
                print('***************** batterLevel ES NULO');
              }
            }
            print(
                '************* respuesta BOTON: ${String.fromCharCodes(respuestas[4])}');
            print('************* respuesta BOTON: ${listString4}');
          });
        }
        break;
    }
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
