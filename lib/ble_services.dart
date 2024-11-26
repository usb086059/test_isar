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
      //await scanDevicesConected();
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

  /*  @override
  notifyListeners(); */
}
