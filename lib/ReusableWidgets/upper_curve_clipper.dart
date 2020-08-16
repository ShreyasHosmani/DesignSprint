import 'package:flutter/material.dart';
import 'dart:ui';

class UpperClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(30, size.height/4);

    var firstEndPoint = Offset(size.width, size.height/1.2);
    var firstControlPoint = Offset(size.width/3.5, size.height/1.2);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}



