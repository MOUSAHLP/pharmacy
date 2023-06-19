import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHeader extends StatelessWidget {
  final Widget child;
  const MyHeader({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RPSCustomPainter(),
      child: child,
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Get.theme.primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, size.height * 0.0);
    path0.quadraticBezierTo(size.width * 1.0001250, size.height * 0.8226571,
        size.width, size.height);
    path0.cubicTo(size.width * 0.9952583, size.height * 0.9165857,
        size.width * -0.0109917, size.height * 0.7050143, 0, size.height);
    path0.quadraticBezierTo(
        size.width * -0.0120333, size.height * 0.7693571, 0, 0);
    path0.lineTo(size.width * 0.5163917, size.height);
    path0.lineTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.0651000, size.height * 0.3609000,
        size.width * 0.0990000, size.height * 0.5847000);
    path0.quadraticBezierTo(size.width * 0.0073667, size.height * 0.3937143, 0,
        size.height * 0.0095000);
    path0.lineTo(0, size.height * 0.3562571);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
