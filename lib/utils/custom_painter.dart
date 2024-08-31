import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xff3a2a6b)
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Define the shape
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2 - 120, 0);
    path.lineTo(size.width / 2 + 120, 0);
    path.lineTo(size.width, size.height);
    path.close(); // Close the path

    // Draw the shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
