import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

/* final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'profile', // ¡Verifica que esté aquí!
  ],
); */

Future<UserCredential?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print(
        '****************************** GoogleSignIn().signIn() returned: $googleUser');

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print(
        '*************************** Access Token: ${googleAuth?.accessToken}');
    print('*************************** ID Token: ${googleAuth?.idToken}');
    print(
        '*************************** googleUser?.authentication returned: $googleAuth');

    //if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
    if (googleAuth?.accessToken != null) {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      print('************************************** No se hizo la credential');
      //El usuario canceló el inicio de sesión de Google o no se obtuvieron las credenciales
      return null;
    }
  } on FirebaseAuthException catch (e) {
    print(
        ' ************************************************Error de Firebase al iniciar sesión con Google: $e');
    // Aquí puedes manejar los diferentes códigos de error de Firebase Authentication
    if (e.code == 'account-exists-with-different-credential') {
      // El correo electrónico ya está asociado con otro proveedor
      // Puedes mostrar un mensaje al usuario indicándole que inicie sesión con ese proveedor
    } else if (e.code == 'invalid-credential') {
      // La credencial de Google no es válida
      // Esto podría indicar un problema con la configuración de Firebase
    } else if (e.code == 'operation-not-allowed') {
      // El inicio de sesión con Google no está habilitado en Firebase
    }
    // ... otros códigos de error ...
    return null; // Indica que el inicio de sesión falló
  } catch (e) {
    print(
        '*********************************************** Error inesperado al iniciar sesión con Google: $e');
    // Manejar otros tipos de errores (por ejemplo, errores de red)
    return null;
  }
}

Future<void> signOutWithGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    print('Sesión cerrada exitosamente (Firebase y Google).');
    // Navegar a la pantalla de inicio de sesión
  } catch (e) {
    print('Error al cerrar sesión con Google: $e');
    // Manejar el error (mostrar mensaje al usuario, etc.)
  }
}
