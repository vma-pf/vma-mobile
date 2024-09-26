import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.tealAccent, Colors.blueAccent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    var path = Path();

    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 4,
      size.height / 4,
      size.width / 2,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width * 3 / 4,
      size.height * 3 / 4,
      size.width,
      size.height / 2,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
