import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclesFullscreenPage extends StatefulWidget {
  @override
  _CirclesFullscreenPageState createState() => _CirclesFullscreenPageState();
}

class _CirclesFullscreenPageState extends State<CirclesFullscreenPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double value = 0.0;
  Animation<double> animation;
  Tween<double> tween;

  @override
  void initState() {
    super.initState();
    math.Random random = math.Random();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCirc);
    tween = Tween(begin: 0, end: 80 + random.nextInt(150).toDouble());

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          math.Random random = math.Random();
          tween = Tween(begin: 0, end: 80 + random.nextInt(150).toDouble());
          _controller.forward();
        }
      })
      ..addListener(() {
        setState(() {
          value = tween.evaluate(animation);
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  double x;
  double y;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        /* onTap: () {
          math.Random random = math.Random();
          tween = Tween(begin: 0, end: 80 + random.nextInt(150).toDouble());
          _controller.forward();
        }, */
        onPanUpdate: (dud) {
          setState(() {
            x = dud.globalPosition.dx;
            y = dud.globalPosition.dy;
          });
        },
        onPanStart: (dud) {
          setState(() {
            x = dud.globalPosition.dx;
            y = dud.globalPosition.dy;
          });
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: CircleWavePainter(value, x, y),
            ),
            Transform.scale(
              scale: 1.1,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CircleWavePainter(value, x, y),
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CircleWavePainter(value, x, y),
              ),
            ),
            Transform.scale(
              scale: 1.3,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CircleWavePainter(value, x, y),
              ),
            ),
            Transform.scale(
              scale: 1.4,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: CircleWavePainter(value, x, y),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleWavePainter extends CustomPainter {
  final double x;
  final double y;
  final double waveRadius;
  Paint wavePaint;
  CircleWavePainter(this.waveRadius, this.x, this.y) {
    wavePaint = Paint()
      ..color = Color((waveRadius * 0xFFFFFF).toInt()).withOpacity(1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..isAntiAlias = true;
  }
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = x != null ? x : size.width / 2.0;
    double centerY = y != null ? y : size.height / 2.0;
    double maxRadius = hypot(centerX, centerY);

    var currentRadius = waveRadius;
    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, wavePaint);
      currentRadius += 100.0;
    }
  }

  @override
  bool shouldRepaint(CircleWavePainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
