import 'package:flutter_application_1/battery_levels.dart';
import 'package:flutter_application_1/device.dart';
import 'package:flutter_application_1/terapia_total.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

final chechProvider = StateProvider<bool?>((ref) => false);

final clickProvider = StateProvider<int>((ref) => 0);

//final colorsProvider = StateProvider((ref) => 0);

final selectModoProvider = StateProvider<bool>((ref) => false);

final indexTerapiaProvider = StateProvider<int>((ref) => 0);

final origenHomeZapperProvider = StateProvider<bool>((ref) => false);

final terapiaProvider0 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final terapiaProvider1 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final terapiaProvider2 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final terapiaProvider3 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final terapiaProvider4 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final terapiaProvider5 = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));

final deviceProvider = StateProvider<Device>((ref) =>
    Device(tipo: '', mac: '', nombre: '', conectado: false, relojAsignado: 0));

final relojProvider = StateProvider<List<String>>((ref) => [
      'dermatronic',
      'disponible',
      'disponible',
      'disponible',
      'disponible',
      'disponible',
    ]);

final reConectarProvider = StateProvider<bool>((ref) => false);

final reConectadoProvider = StateProvider<bool>((ref) => false);

final primerArranqueProvider = StateProvider<bool>((ref) => false);

final batteryLevelProvider = StateProvider<String>((ref) => batteryLevels[0]);

// stateProvider para avisar que el usuario uso el boton cerrar sesión en bleScreen
final cerroSesionProvider = StateProvider<bool>((ref) => false);

final batteryProvider =
    StateProvider<String>((ref) => 'assets/icons/bateriaAzulMarco.png');

final batteryAzulProvider =
    StateProvider<String>((ref) => 'assets/icons/bateriaAzulMarco.png');

final isScanEnabledProvider = StateProvider<bool>((ref) => true);

final isApagarEnabledProvider = StateProvider<bool>((ref) => true);

final isLoadingTerapiaTotale = StateProvider<bool>((ref) => false);

final isEnabledButtonConectarProvider = StateProvider<bool>((ref) =>
    true); // Para habilitar/deshabilitar el boton concetar en el showDialog de la asignación de nombre del equipo conectado

final isComingFromSomeTimerScreen = StateProvider<bool>((ref) => false);

final isEnableButtonSelectDeviceScannedProvider =
    StateProvider<bool>((ref) => true);

final isEnabledButtonPlayProvider = StateProvider<bool>((ref) => true);
