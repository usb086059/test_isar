import 'package:flutter/material.dart';

Gradient fondoLoginScreenGradient() {
  return const RadialGradient(
      colors: [Colors.white, Color.fromARGB(255, 50, 102, 175)],
      radius: 2.5,
      stops: [0.14, 1]);
}

Gradient azulGradient() {
  return const RadialGradient(
      focal: Alignment.topRight,
      colors: [
        Color.fromARGB(255, 94, 202, 233),
        Color.fromARGB(
          255,
          52,
          78,
          153,
        ),
        Color.fromARGB(255, 51, 80, 152)
      ],
      radius: 5,
      stops: [0.0, 0.5, 1]);
}

Gradient azulGradientFloatingActionButton() {
  return const RadialGradient(
      focal: Alignment.topRight,
      colors: [
        Color.fromARGB(255, 94, 202, 233),
        Color.fromARGB(
          255,
          52,
          78,
          153,
        ),
        Color.fromARGB(255, 51, 80, 152)
      ],
      radius: 5,
      stops: [0.0, 0.2, 1]);
}

Gradient gradientAlertDialog() {
  return RadialGradient(
      focal: Alignment.topRight,
      colors: [
        Colors.blue.withOpacity(0.6),
        Colors.blue.withOpacity(0.3),
        Colors.blue.withOpacity(0.1)
      ],
      radius: 10,
      stops: const [0.0, 0.1, 1]);
}
