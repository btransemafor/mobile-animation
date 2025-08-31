import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sin_wave/implicit_animation/implicit.dart';

void main() {
  
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CustomLogoFade());
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // chạy lặp vô hạn
  }

  @override
  void dispose() {
    _controller.dispose(); // đừng quên dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Demo'),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: SinPainter(progress: _controller.value),
          );
        },
      ),
    );
  }
}

class SinPainter extends CustomPainter {
  final double progress;
  SinPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Bút vẽ sóng
    final paint = Paint()
      ..color = Colors.blue.withOpacity(1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    double phaseShift = pi / 4; // dịch sang trái/phải

    double yInitial =
        100 * sin((0 / size.width) * 2 * pi * 2 + phaseShift) + size.height / 2;
    path.moveTo(0, yInitial);

    for (double x = 0; x <= size.width; x++) {
      double y = 100 * sin((x / size.width) * 2 * pi * 2 + phaseShift) +
          size.height / 2;
      path.lineTo(x, y);
    }

    // Tính toạ độ chấm tròn
    double currentX = progress * size.width;
    double currentY =
        100 * sin((currentX / size.width) * 2 * pi * 2 + phaseShift) +
            size.height / 2;

    // Vẽ sóng
    canvas.drawPath(path, paint);

    // Vẽ chấm tròn
    canvas.drawCircle(
      Offset(currentX, currentY),
      15,
      Paint()..color = Colors.blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
