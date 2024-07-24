import 'package:flutter_application_1/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final datoProvider =
    FutureProvider.autoDispose((ref) => ref.watch(servicesProvider).getAll());

final newProvider = FutureProvider.autoDispose(
    (ref) => ref.watch(servicesProvider).terapiasIniciales());
