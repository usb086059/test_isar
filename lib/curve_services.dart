import 'package:flutter/material.dart';

class LoginCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.arcToPoint(
      Offset(size.width * 0.3, size.height * 0.103),
      radius: const Radius.circular(105),
      clockwise: false,
    );
    path.lineTo(size.width * 0.7, size.height * 0.103);
    path.arcToPoint(
      Offset(size.width, size.height * 0.206),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width, size.height * 0.794);
    path.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.897),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width * 0.2, size.height * 0.897);
    path.arcToPoint(
      Offset(0, size.height),
      radius: const Radius.circular(80),
      clockwise: false,
    );

/*     path.quadraticBezierTo(size.width * 0.1, size.height * 0.152,
        size.width * 0.5, size.height * 0.152);
    path.quadraticBezierTo(size.width * 0.75, size.height * -0.0,
        size.width * 0.97, size.height * 0.15); */
    //path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class TimerScreenCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.arcToPoint(
      Offset(size.width * 0.3, size.height * 0.103),
      radius: const Radius.circular(105),
      clockwise: false,
    );
    path.lineTo(size.width * 0.7, size.height * 0.103);
    path.arcToPoint(
      Offset(size.width, size.height * 0.206),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width, size.height * 0.41);
    path.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.513),
      radius: const Radius.circular(105),
      clockwise: true,
    );
    path.lineTo(size.width * 0.2, size.height * 0.513);
    path.arcToPoint(
      Offset(0, size.height * 0.616),
      radius: const Radius.circular(80),
      clockwise: false,
    );

/*     path.quadraticBezierTo(size.width * 0.1, size.height * 0.152,
        size.width * 0.5, size.height * 0.152);
    path.quadraticBezierTo(size.width * 0.75, size.height * -0.0,
        size.width * 0.97, size.height * 0.15); */
    //path.lineTo(size.width, size.height);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
