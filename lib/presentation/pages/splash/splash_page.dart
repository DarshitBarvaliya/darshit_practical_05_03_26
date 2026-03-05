import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<Offset> _slideUpAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // Total 3 seconds
    );

    // Wave moving from bottom (0) to top (1)
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut), // 0 to 1.5s
      ),
    );

    // Logo scale and fade
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            const Interval(0.2, 0.5, curve: Curves.easeOutBack), // 0.6s to 1.5s
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );

    // Slide up whole screen at the end
    _slideUpAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1.0)).animate(
      CurvedAnimation(
        parent: _controller,
        curve:
            const Interval(0.85, 1.0, curve: Curves.easeInOut), // 2.5s to 3.0s
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offNamed(Routes.HOME);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Match Home background color
      body: SlideTransition(
        position: _slideUpAnimation,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(_waveAnimation.value),
              child: Center(
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: const Hero(
            tag: 'app_logo',
            child: Material(
              color: Colors.transparent,
              child: Text(
                'Logo',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;

  WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF00B4DB), // Cyan
          Color(0xFF6A1B9A), // Purple
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Wave amplitude
    double waveHeight = 60.0;

    // As progress approaches 1.0, we fill the whole screen, moving the wave above the top edge
    double yPos = size.height - (size.height + waveHeight * 2) * progress;

    path.moveTo(0, size.height);
    path.lineTo(0, yPos);

    // Draw the curved wave
    path.quadraticBezierTo(
      size.width * 0.5, yPos - waveHeight * 1.5, // Control point 1
      size.width, yPos, // End point 1
    );

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
