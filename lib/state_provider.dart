import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

final chechProvider = StateProvider<bool?>((ref) => false);

final clickProvider = StateProvider<int>((ref) => 0);

//final colorsProvider = StateProvider((ref) => 0);
