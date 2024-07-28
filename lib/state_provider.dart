import 'package:flutter_application_1/terapia_total.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

final chechProvider = StateProvider<bool?>((ref) => false);

final clickProvider = StateProvider<int>((ref) => 0);

//final colorsProvider = StateProvider((ref) => 0);

final selectModoProvider = StateProvider<bool>((ref) => false);

final indexTerapiaProvider = StateProvider<int>((ref) => 0);

final origenHomeZapperProvider = StateProvider<bool>((ref) => false);

final terapiaProvider = StateProvider<TerapiaTotal>((ref) => TerapiaTotal(
    nombre: '',
    frecMin: 1,
    frecMax: 1,
    info: 'Agregue una breve descripción de la terapia',
    editable: false,
    idTerapiaPersonal: 0));
