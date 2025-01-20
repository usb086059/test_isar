import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final conectionProvicer = ChangeNotifierProvider((ref) => ConectionProvider());

class ConectionProvider extends ChangeNotifier {
  Map<String, bool> conectados = {};

  void actualizarConectados(String remoteId, bool conectado) {
    conectados[remoteId] = conectado;
    notifyListeners();
  }
}
