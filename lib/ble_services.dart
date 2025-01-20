//import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/comandos.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flutter_application_1/local_notification_services.dart';

final bleProvider = ChangeNotifierProvider((ref) => BleServices());

class BleServices extends ChangeNotifier {
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
      device.disconnect();
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

  Future<void> desconectar(BluetoothDevice device) async {
    FlutterBluePlus.stopScan();
    await device.disconnect();
    await scanDevices(0);
    //await scanDevicesConected();
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

    //await scanDevicesConected();
    notifyListeners();
  }

  Future<void> enviarDataBLE(
      String remoteId, String comando, TerapiaTotal terapia) async {
    if (comando == listComandos['ON']! && terapia.frecMin == terapia.frecMax) {
      comando = '${listComandos['fija']!}$comando';
    }
    //comando = comando.padLeft(8, '>');
    String frecMin = '${listComandos['Fmin']!}${terapia.frecMin.toString()}*';
    String frecMax = '${listComandos['Fmax']!}${terapia.frecMax.toString()}*';

    final BluetoothDevice device = FlutterBluePlus.connectedDevices
        .firstWhere((element) => element.remoteId.toString() == remoteId);

    List<BluetoothService> listServicios = await device.discoverServices();
    /* for (var element in listServicios) {
      String serviceUuid = element.serviceUuid.toString();
      var char = element.characteristics;
      print('>>>>>>>>>>>> $serviceUuid');
      print('<<<<<<<<<<<< $char');
    } */

    final caracteristica = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));

    /* final List<int> letra1Fmin = frecMin.substring(0, 1).codeUnits;
    final List<int> letra2Fmin = frecMin.substring(1, 2).codeUnits;
    final List<int> letra3Fmin = frecMin.substring(2, 3).codeUnits;
    final List<int> letra4Fmin = frecMin.substring(3, 4).codeUnits;
    final List<int> letra5Fmin = frecMin.substring(4, 5).codeUnits;
    final List<int> letra6Fmin = frecMin.substring(5, 6).codeUnits;
    final List<int> letra7Fmin = frecMin.substring(6, 7).codeUnits;
    final List<int> letra8Fmin = frecMin.substring(7).codeUnits;

    final List<int> letra1Fmax = frecMax.substring(0, 1).codeUnits;
    final List<int> letra2Fmax = frecMax.substring(1, 2).codeUnits;
    final List<int> letra3Fmax = frecMax.substring(2, 3).codeUnits;
    final List<int> letra4Fmax = frecMax.substring(3, 4).codeUnits;
    final List<int> letra5Fmax = frecMax.substring(4, 5).codeUnits;
    final List<int> letra6Fmax = frecMax.substring(5, 6).codeUnits;
    final List<int> letra7Fmax = frecMax.substring(6, 7).codeUnits;
    final List<int> letra8Fmax = frecMax.substring(7).codeUnits; */

    /* final List<int> letra1Comando = comando.substring(0, 1).codeUnits;
    final List<int> letra2Comando = comando.substring(1, 2).codeUnits;
    final List<int> letra3Comando = comando.substring(2, 3).codeUnits;
    final List<int> letra4Comando = comando.substring(3, 4).codeUnits;
    final List<int> letra5Comando = comando.substring(4, 5).codeUnits;
    final List<int> letra6Comando = comando.substring(5, 6).codeUnits;
    final List<int> letra7Comando = comando.substring(6, 7).codeUnits;
    final List<int> letra8Comando = comando.substring(7).codeUnits; */

    //await caracteristica.setNotifyValue(true);

    /* List<int> respuesta = [];
    final subscriptionCaracteristica =
        caracteristica.onValueReceived.listen((event) {
      respuesta.addAll(event);
    }); */

    const int delayEntreEnviosPaquete = 30;

    if (comando.contains(listComandos['ON']!)) {
      for (int i = 1; i <= frecMin.length; i++) {
        await caracteristica.write(frecMin.substring(i - 1, i).codeUnits,
            withoutResponse: true);
        await Future.delayed(
            const Duration(milliseconds: delayEntreEnviosPaquete));
      }

      /* await caracteristica.write(letra1Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra2Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra3Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra4Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra5Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra6Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra7Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra8Fmin, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete)); */

      for (int i = 1; i <= frecMax.length; i++) {
        await caracteristica.write(frecMax.substring(i - 1, i).codeUnits,
            withoutResponse: true);
        await Future.delayed(
            const Duration(milliseconds: delayEntreEnviosPaquete));
      }

      /* await caracteristica.write(letra1Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra2Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra3Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra4Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra5Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra6Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra7Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
      await caracteristica.write(letra8Fmax, withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete)); */
    }

    for (int i = 1; i <= comando.length; i++) {
      await caracteristica.write(comando.substring(i - 1, i).codeUnits,
          withoutResponse: true);
      await Future.delayed(
          const Duration(milliseconds: delayEntreEnviosPaquete));
    }
    print('>>>>>>>>>>$frecMin');
    print('>>>>>>>>>>$frecMax');
    print('>>>>>>>>>>$comando');

    /* await caracteristica.write(letra1Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra2Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra3Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra4Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra5Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra6Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra7Comando, withoutResponse: true);
    await Future.delayed(const Duration(milliseconds: delayEntreEnviosPaquete));
    await caracteristica.write(letra8Comando, withoutResponse: true); */

    /* await Future.delayed(const Duration(milliseconds: 500));
    String resp = String.fromCharCodes(respuesta);
    await Future.delayed(const Duration(milliseconds: 500));
    print('>>>>>>> $resp');
    await subscriptionCaracteristica.cancel(); */
    //device.cancelWhenDisconnected(subscriptionCaracteristica);
  }

  /* Future<void> delay() async {
    Future.delayed(const Duration(seconds: 6), () {
      return;
    });
  } */

  /*  @override
  notifyListeners(); */
}
