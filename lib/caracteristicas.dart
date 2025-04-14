/* import 'dart:async';

//import 'package:flutter/material.dart';
//import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/battery_levels.dart';
import 'package:flutter_application_1/ble_services.dart';
import 'package:flutter_application_1/countdown_provider.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/state_provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:isar/isar.dart';

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

Future<String> caracteristicas(
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
    return bateriaxxx;
  } else {
    BluetoothCharacteristic caracteristicaBase = BluetoothCharacteristic(
        remoteId: device.remoteId,
        serviceUuid: Guid('FFE0'),
        characteristicUuid: Guid('FFE1'));
    await caracteristicaBase.setNotifyValue(true);
    for (int i = 0; i < 5; i++) {
      if (listCaracteristicas[i].remoteId.toString() == 'disponible') {
        listCaracteristicas[i] = caracteristicaBase;
        caseNumber = i;
        escuchas();
        i = 5;
      }
    }
    return bateriaxxx;
  }
}

void escuchas() {
  switch (caseNumber) {
    case 0:
      subscriptionCaracteristica0?.cancel();
      if (!deviceDisconnected) {
        subscriptionCaracteristica0 = listCaracteristicas[caseNumber]
            .onValueReceived
            .listen((event) async {
          //final bs = container.read(batteryServicesProvider.notifier);
          if (!String.fromCharCodes(event).contains('*')) {
            respuestas[caseNumber].clear();
          }
          respuestas[caseNumber].clear();
          respuestas[caseNumber].addAll(event);
          List<String> listString =
              String.fromCharCodes(respuestas[caseNumber]).split('*');
          listString.removeLast();
          for (String element in listString) {
            final int? batteryLevel = int.tryParse(element);
            if (batteryLevel != null) {
              print('**************** batteryLevel: $batteryLevel');
              bateriaxxx = selectBatteryLevelImage(batteryLevel);
              container.read(bleProvider).setBleservicesBatery = bateriaxxx;
              //container.read(countdownProvider).updateBat(bateriaxxx);
              /* container.read(bleProvider.notifier).bleServicesBatery =
                  bateriaxxx; */
              //BatteryServices().selectBatteryLevelImage(batteryLevel);
              print(
                  '**************** batteryLevelAddress: ${container.read(bleProvider.notifier).bleServicesBatery}');
              /* print(
                  '**************** batteryLevelSTATE: ${container.read(bleProvider.notifier).bleServicesBatery}'); */
            } else {
              print('***************** batterLevel ES NULO');
            }
          }
          print(
              '************* respuesta BOTON: ${String.fromCharCodes(respuestas[caseNumber])}');
          print('************* respuesta BOTON: ${listString}');
        });
      }
      break;
    case 1:
      subscriptionCaracteristica1?.cancel();
      if (!deviceDisconnected) {
        subscriptionCaracteristica1 =
            listCaracteristicas[caseNumber].onValueReceived.listen((event) {
          respuestas[caseNumber].clear();
          respuestas[caseNumber].addAll(event);
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
 */