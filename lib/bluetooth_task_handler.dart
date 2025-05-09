import 'dart:async';
import 'dart:ui';
import 'dart:isolate'; // Importa dart:isolate para SendPort
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothForegroundTaskHandler extends TaskHandler {
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  final StreamController<String> _logController =
      StreamController<String>.broadcast();
  Stream<String> get logStream => _logController.stream;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    // Escucha el estado del adaptador Bluetooth
    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _logController.add('Bluetooth State: $state');
      FlutterForegroundTask.sendDataToMain(
          'Bluetooth State: $state'); // Envía el estado a la UI
    });

    _logController.add('Foreground Task Started at: $timestamp');
    FlutterForegroundTask.sendDataToMain(
        'Foreground Task Started at:  $timestamp'); // Envía inicio a la UI
  }

  /*  @override
  Future<void> onEvent(DateTime timestamp, SendPort? sendPort) async {
    // Aquí puedes manejar eventos enviados desde la UI si los necesitas
  } */

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    // Cancela las suscripciones y libera recursos
    await _adapterStateSubscription?.cancel();
    await _logController.close();
    _logController.add('Foreground Task Destroyed at: $timestamp');
    FlutterForegroundTask.sendDataToMain(
        'Foreground Task Destroyed at: $timestamp'); // Envía destrucción a la UI
  }

  // Métodos para interactuar con Bluetooth (ejemplos):

  Future<void> startScan(SendPort? sendPort) async {
    final adapterState = await FlutterBluePlus.adapterState.first;
    if (adapterState == BluetoothAdapterState.on) {
      _logController.add('Starting Bluetooth Scan...');
      sendPort?.send('Starting Bluetooth Scan...');
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          _logController.add('${r.device.advName} found! rssi: ${r.rssi}');
          sendPort?.send(
              '${r.device.advName} found! rssi: ${r.rssi}'); // Envía resultados a la UI
        }
      });
      await FlutterBluePlus.stopScan();
      _logController.add('Bluetooth Scan Stopped.');
      sendPort?.send('Bluetooth Scan Stopped.');
    } else {
      _logController.add('Bluetooth is off, cannot start scan.');
      sendPort?.send('Bluetooth is off, cannot start scan.');
    }
  }

  Future<bool> connectToDevice(
      DeviceIdentifier deviceId, SendPort? sendPort) async {
    try {
      BluetoothDevice device = BluetoothDevice(
          remoteId: deviceId); // Necesitas el ID del dispositivo
      _logController.add('Connecting to ${device.remoteId}...');
      sendPort?.send('Connecting to ${device.remoteId}...');
      await device.connect();
      _logController.add('Connected to ${device.remoteId}');
      sendPort?.send('Connected to ${device.remoteId}');
      return true;
    } catch (e) {
      _logController.add('Error connecting: $e');
      sendPort?.send('Error connecting: $e');
      return false;
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // TODO: implement onRepeatEvent
  }

  // ... otros métodos para leer, escribir, desconectar, etc.
}
