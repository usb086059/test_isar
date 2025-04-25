// Lista de url para encontrar las imagenes
// correspondientes a los niveles de bateria
// dentro de la carpeta Assets
//import 'package:flutter/material.dart';
//import 'package:flutter_application_1/main.dart';
//import 'package:flutter_application_1/state_provider.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
/* 
final batteryServicesProvider =
    ChangeNotifierProvider((ref) => BatteryServices()); */

final List<String> batteryLevels = [
  'assets/icons/bateriaAzulMarco.png',
  'assets/icons/bateria0.png',
  'assets/icons/bateria25.png',
  'assets/icons/bateria50.png',
  'assets/icons/bateria75.png',
  'assets/icons/bateria100.png'
];

/* final List<String> batteryLevelsAzul = [
  'assets/icons/bateriaAzulMarco.png',
  'assets/icons/bateriaAzul0.png',
  'assets/icons/bateriaAzul25.png',
  'assets/icons/bateriaAzul50.png',
  'assets/icons/bateriaAzul75.png',
  'assets/icons/bateriaAzul100.png'
]; */

String batteryLevelx = batteryLevels[0];
//String batteryLevelxAzul = batteryLevels[0];

String selectBatteryLevelImage(int caseNumber) {
  print('**************** bateryLevelDireccion: $batteryLevelx');
  if (caseNumber == 0) {
    batteryLevelx = batteryLevels[1];
  }
  if (caseNumber == 25) {
    batteryLevelx = batteryLevels[2];
  }
  if (caseNumber == 50) {
    batteryLevelx = batteryLevels[3];
  }
  if (caseNumber == 75) {
    batteryLevelx = batteryLevels[4];
  }
  if (caseNumber == 100) {
    batteryLevelx = batteryLevels[5];
  }
  return batteryLevelx;
}

/* String selectBatteryLevelImageAzul(int caseNumber) {
  print('**************** bateryLevelDireccion: $batteryLevelxAzul');
  if (caseNumber == 0) {
    batteryLevelxAzul = batteryLevels[1];
  }
  if (caseNumber == 25) {
    batteryLevelxAzul = batteryLevels[2];
  }
  if (caseNumber == 50) {
    batteryLevelxAzul = batteryLevels[3];
  }
  if (caseNumber == 75) {
    batteryLevelxAzul = batteryLevels[4];
  }
  if (caseNumber == 100) {
    batteryLevelxAzul = batteryLevels[5];
  }
  return batteryLevelxAzul;
} */
