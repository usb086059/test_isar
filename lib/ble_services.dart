//import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

final bleProvider = ChangeNotifierProvider((ref) => BleServices());

class BleServices extends ChangeNotifier {
  Future<bool> bleState() async {
    bool bluetoothState = false;
    // handle bluetooth on & off
// note: for iOS the initial state is typically BluetoothAdapterState.unknown
// note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
    StreamSubscription<BluetoothAdapterState> subscription = FlutterBluePlus
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
    subscription.cancel();
    return bluetoothState;
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

  Future<void> conectar(BluetoothDevice device) async {
    FlutterBluePlus.stopScan();
    await device.connect();
    if (device.isConnected) {
      await scanDevices(0);
    }
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
    FlutterBluePlus.stopScan();
    final BluetoothDevice device = FlutterBluePlus.connectedDevices
        .firstWhere((element) => element.remoteId.toString() == reomteId);
    await device.disconnect();
    await scanDevices(0);
    //await scanDevicesConected();
    notifyListeners();
  }

  Future<void> crearServicioBLE(String remoteId, String comando) async {
    final BluetoothDevice device = FlutterBluePlus.connectedDevices
        .firstWhere((element) => element.remoteId.toString() == remoteId);

    List<BluetoothService> listServicios = await device.discoverServices();
    for (var element in listServicios) {
      String serviceUuid = element.serviceUuid.toString();
      var char = element.characteristics;
      print('>>>>>>>>>>>> $serviceUuid');
      print('<<<<<<<<<<<< $char');
    }

    final caracteristica = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));

    final List<int> letra1 = comando.substring(0, 1).codeUnits;
    final List<int> letra2 = comando.substring(1, 2).codeUnits;
    final List<int> letra3 = comando.substring(2, 3).codeUnits;
    final List<int> letra4 = comando.substring(3, 4).codeUnits;
    final List<int> letra5 = comando.substring(4, 5).codeUnits;
    final List<int> letra6 = comando.substring(5).codeUnits;

    await caracteristica.write(letra1, withoutResponse: true);
    //delay();
    caracteristica.write(letra2, withoutResponse: true);
    //delay();
    caracteristica.write(letra3, withoutResponse: true);
    //delay();
    caracteristica.write(letra4, withoutResponse: true);
    //delay();
    caracteristica.write(letra5, withoutResponse: true);
    //delay();
    caracteristica.write(letra6, withoutResponse: true);
  }

  /*  Future<void> delay() async {
    Future.delayed(const Duration(milliseconds: 1), () {
      return;
    });
  } */

  /*  @override
  notifyListeners(); */
}
