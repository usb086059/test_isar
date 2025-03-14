import 'package:flutter_application_1/terapia_total.dart';

class PackComando {
  String deviceMac;
  String comando;
  TerapiaTotal terapia;
  bool enviado;

  PackComando(
      {required this.deviceMac,
      required this.comando,
      required this.terapia,
      this.enviado = false});
}
