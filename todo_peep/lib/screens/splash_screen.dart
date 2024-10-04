import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // 서서히 나타나는 애니메이션을 위한 컨트롤러
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2), // 2초 동안 서서히 나타나게
      vsync: this,
    );

    // 텍스트 회전 애니메이션을 위한 컨트롤러
    _rotationController = AnimationController(
      duration: const Duration(seconds: 1), // 1초 동안 회전
      vsync: this,
    );

    // 0에서 1로 서서히 나타나는 애니메이션
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);

    // 0에서 90도까지 회전하는 애니메이션
    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_rotationController);

    // 서서히 나타나는 애니메이션 시작
    _fadeController.forward();

    // 텍스트가 서서히 나타난 후 회전 애니메이션 시작
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.forward();
      }
    });

    // 5초 후에 스플래시 스크린이 서서히 사라지며 초기 화면으로 이동
    Future.delayed(const Duration(seconds: 3), () {
      _fadeController.reverse(); // 화면 서서히 사라지게
      Future.delayed(const Duration(seconds: 1), () {
        Get.toNamed("/"); // 초기 화면으로 이동
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation, // 서서히 나타나고 사라짐
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Our Plan',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              // :D 텍스트에 회전 애니메이션 적용
              AnimatedBuilder(
                animation: _rotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * (3.14 / 2), // 90도 회전
                    child: child,
                  );
                },
                child: const Text(
                  ':D',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    color: Color(0xFFA3A7FF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
