import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/gradient_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvisoErrorConexion extends ConsumerWidget {
  final String title;
  final String content;
  const AvisoErrorConexion(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Stack(children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: heightScreen * 0.214,
                  maxWidth: widthScreen * 0.783),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(),
              ),
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              constraints: BoxConstraints(
                  maxHeight: heightScreen * 0.214,
                  maxWidth: widthScreen * 0.783),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(30),
                  gradient: gradientAlertDialog()),
              child: Container(),
            ),
          ),
        ),
        AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                //fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}
