import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Provider que expone el Stream de cambios de estado de Firebase Auth.
// Este es el enfoque recomendado por Riverpod para Firebase Auth.
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// 2. Provider que expone la URL de la imagen (o la URL por defecto).
final userImageProvider = Provider<String>((ref) {
  // Observa (watch) el estado de autenticación.
  final authState = ref.watch(authStateProvider);

  // Analiza el estado del Stream
  return authState.when(
    data: (user) {
      if (user != null && user.photoURL != null && user.photoURL!.isNotEmpty) {
        // Devuelve la URL real si el usuario está conectado y tiene una foto.
        return user.photoURL!;
      }
      // Devuelve una cadena única para el icono por defecto si está conectado sin foto
      // o si está cargando.
      // Aquí puedes usar un valor constante, pero si usas el UID aseguras la unicidad.
      return user?.uid ?? 'assets/icons/iconoCircular.png';
    },
    // Mientras carga o si hay error, usa la imagen por defecto
    loading: () => 'assets/icons/iconUserNoImage.png',
    error: (err, stack) => 'assets/icons/iconUserNoImage.png',
  );
});

final userIsAuthenticatedProvider = StateProvider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final User? user = authState.valueOrNull;
  return user != null;
});
