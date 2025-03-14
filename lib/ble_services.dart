//import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flutter_application_1/local_notification_services.dart';
import 'package:flutter_application_1/pack_comando.dart';

final bleProvider = ChangeNotifierProvider((ref) => BleServices());

BluetoothCharacteristic caracteristica = BluetoothCharacteristic(
    remoteId: const DeviceIdentifier('str'),
    serviceUuid: Guid('FFE0'),
    characteristicUuid: Guid('FFE1'));

bool bussy = false;

List<PackComando> commandQueue = [];
List<PackComando> listBackupCommand = [];
bool isSending = false;

class BleServices extends ChangeNotifier {
  StreamSubscription<List<int>>? subscriptionCaracteristica;

  bool get isBussy {
    return bussy;
  }

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
        //await Future.delayed(const Duration(seconds: 3));
      }
    }

    /* int elMTU = await device.requestMtu(512);
    await Future.delayed(const Duration(seconds: 16));
    print('>>>>>>>>>> El MTU negociaodo es: $elMTU'); */
    notifyListeners();
  }

  set setCaracteristica(BluetoothCharacteristic _caracteristica) {
    caracteristica = _caracteristica;
  }

  Future<void> descubrirServicios(BluetoothDevice device) async {
    List<BluetoothService> listServicios = await device.discoverServices();
    caracteristica = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));
    await caracteristica.setNotifyValue(true);
  }

  BluetoothCharacteristic get gCaracteristica {
    return caracteristica;
  }

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
          print('**************** listBackupCommand => ${listBackupCommand}');
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
    List<int> respuesta = [];
    print(
        '********************************* respuesta *************** ${String.fromCharCodes(respuesta)}');
    subscriptionCaracteristica?.cancel();
    subscriptionCaracteristica = caracteristica.onValueReceived.listen((event) {
      respuesta.clear();
      respuesta.addAll(event);
      //subscriptionCaracteristica?.cancel();
      print(
          '********************************************************* este es event ${event} ************');
    });

    print(
        '********************NotifyValue ************** ${caracteristica.isNotifying}');

    const int delayEntreEnviosPaquete = 30;

    if (comando.contains(listComandos['ON']!)) {
      for (int i = 1; i <= frecMin.length; i++) {
        await caracteristica.write(frecMin.substring(i - 1, i).codeUnits,
            withoutResponse: true);
        await Future.delayed(
            const Duration(milliseconds: delayEntreEnviosPaquete));
      }
      await Future.delayed(const Duration(milliseconds: 100));
      if (frecMin == String.fromCharCodes(respuesta)) {
        respuesta.clear();
        for (int i = 1; i <= frecMax.length; i++) {
          await caracteristica.write(frecMax.substring(i - 1, i).codeUnits,
              withoutResponse: true);
          await Future.delayed(
              const Duration(milliseconds: delayEntreEnviosPaquete));
        }
        await Future.delayed(const Duration(milliseconds: 100));
        if (frecMax == String.fromCharCodes(respuesta)) {
          respuesta.clear();
        } else {
          subscriptionCaracteristica?.cancel();
          device.cancelWhenDisconnected(subscriptionCaracteristica!);
          return false;
        }
      } else {
        subscriptionCaracteristica?.cancel();
        device.cancelWhenDisconnected(subscriptionCaracteristica!);
        return false; //comandoEnviado;
      }
    }

    for (int i = 1; i <= comando.length; i++) {
      await caracteristica.write(comando.substring(i - 1, i).codeUnits,
          withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      print(
          '********************************* i del for comando *************** $i');
    }
    await Future.delayed(const Duration(milliseconds: 100));
    print(
        '********************************* respuesta DESPUES DEL FOR *************** ${String.fromCharCodes(respuesta)}');
    if (comando == String.fromCharCodes(respuesta)) {
      respuesta.clear();
      subscriptionCaracteristica?.cancel();
      device.cancelWhenDisconnected(subscriptionCaracteristica!);
      print('>>>>>>>>>>$frecMin');
      print('>>>>>>>>>>$frecMax');
      print('>>>>>>>>>>$comando');
      //CountdownProvider().setBussy = false;
      bussy = false;
      return true;
    } else {
      respuesta.clear();
      subscriptionCaracteristica?.cancel();
      device.cancelWhenDisconnected(subscriptionCaracteristica!);
      //CountdownProvider().setBussy = false;
      bussy = false;
      return false;
    }
    /* print(
        'lenght: ${respuesta.length} -- Valores: ${String.fromCharCodes(respuesta)}');
    subscriptionCaracteristica.cancel(); */
  }
}
