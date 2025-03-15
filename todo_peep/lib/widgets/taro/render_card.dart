import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math';

import 'package:todo_peep/controllers/taro_controller.dart';

class RenderCard extends StatefulWidget {
  const RenderCard({super.key});

  @override
  _RenderCardState createState() => _RenderCardState();
}

class _RenderCardState extends State<RenderCard> with TickerProviderStateMixin {
  final TaroController controller = Get.find<TaroController>();

  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool showFront = false; // 카드의 초기 상태는 뒷면

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_rotationController)
          ..addListener(() {
            // 회전의 중간 지점에서 앞면으로 전환
            if (_rotationAnimation.value >= 0.5 && !showFront) {
              setState(() {
                showFront = true;
              });
            }
          });

    // 회전이 완료된 후에 사라지는 페이드 아웃 애니메이션
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // 투명도 애니메이션 (1에서 0으로 감소)
    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    // 회전 애니메이션 시작
    _rotationController.forward().then((_) {
      // 회전이 끝나면 페이드 아웃 시작
      Future.delayed(const Duration(milliseconds: 500), () {
        // 지연 후 페이드 아웃 애니메이션 시작
        _fadeController.forward().whenComplete(() {
          controller.animation(false);
          if (controller.number.toInt() == 0) {
            controller.loveFortuneAnimation(true);
          } else if (controller.number.toInt() == 2) {
            controller.wealthFortuneAnimation(true);
          } else {
            controller.studyFortuneAnimation(true);
          }
          controller.addNumber();
        });
      });
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationAnimation, _fadeAnimation]),
      builder: (context, child) {
        // 회전 각도 계산 (0에서 pi까지 회전)
        double angle = pi * _rotationAnimation.value;

        // 회전 중간에서 카드 앞/뒷면 선택
        final currentImage = showFront
            ? "assets/images/taro/taroCard/${controller.selectedCards[controller.number.toInt()]}.png"
            : "assets/images/taro/taroCard.png";

        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..scale(-1.0, 1.0, 1.0) // 좌우 반전
              ..rotateY(angle), // Y축 회전

            child: Transform.rotate(
              angle: controller.selectedCards[controller.number.toInt() + 1] ==
                      true
                  ? pi
                  : 0,
              child: Image.asset(
                currentImage,
                width: 64.75,
                height: 108.28,
              ),
            ),
          ),
        );
      },
    );
  }
}
