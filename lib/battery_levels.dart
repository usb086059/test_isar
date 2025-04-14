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
  'assets/icons/bateriaMarco.png',
  'assets/icons/bateria0.png',
  'assets/icons/bateria25.png',
  'assets/icons/bateria50.png',
  'assets/icons/bateria75.png',
  'assets/icons/bateria100.png'
];

/* class BatteryServices extends ChangeNotifier {
  BatteryServices() {
    print('****************** Constructor de BatteryServices llamado');
  } */
String batteryLevelx = batteryLevels[0];
/* String get getBattery {
    return batteryLevelx;
  } */

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
  //container.read(batteryServicesProvider).notifyListeners();
  /* try {
      notifyListeners();
      print('**************** bateryLevelLuego del Notify: $batteryLevelx');
    } catch (e) {
      print('********************* notifyError: $e');
    } */
  //notifyListeners();
  //print('**************** bateryLevelLuego del Notify: $batteryLevelx');
/*     switch (caseNumber) {
      case 0:
        batteryLevel = batteryLevels[1];
        notifyListeners();
        break;
      case 25:
        batteryLevel = batteryLevels[2];
        notifyListeners();
        break;
      case 50:
        batteryLevel = batteryLevels[3];
        print('**************** Nivel 50 >>> caseNumber: $batteryLevel');
        notifyListeners();
        break;
      case 75:
        batteryLevel = batteryLevels[4];
        notifyListeners();
        break;
      case 100:
        batteryLevel = batteryLevels[5];
        notifyListeners();
        break;
      default:
        batteryLevel = batteryLevels[0];
        notifyListeners();
        break;
    } */
  return batteryLevelx;
}
//}
