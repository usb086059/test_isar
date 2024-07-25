import 'package:flutter/material.dart';

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
