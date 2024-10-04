import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';

class TarotCardCircle extends StatefulWidget {
  const TarotCardCircle({super.key});

  @override
  State<TarotCardCircle> createState() => _TarotCardCircleState();
}

class _TarotCardCircleState extends State<TarotCardCircle> {
  final TaroController taroController = Get.find<TaroController>();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var radius = screenWidth * 0.3; // 반지름을 0.5 * screenWidth로 변경
    var cardCount = 21; // 카드의 개수
    var centerX = (screenWidth - 58) / 2; // 화면 중심의 X 좌표
    var centerY = (screenWidth - 58) / 2; // 화면 중심의 Y 좌표

    return Stack(
      children: [
        for (int i = 0; i < cardCount; i++)
          Transform.translate(
            // 카드가 원의 중심에서 벗어나도록 offset 조정
            offset: Offset(
              radius * cos(2 * pi * i / cardCount) +
                  centerX -
                  32.375, // X 좌표 이동
              radius * sin(2 * pi * i / cardCount) + centerY - 54.14, // Y 좌표 이동
            ),
            child: Transform.rotate(
              angle: 2 * pi * i / cardCount + pi / 2, // 각도를 따라 카드 회전
              child: GestureDetector(
                onTap: () {
                  taroController.selectTaroCard();
                },
                child: Image.asset(
                  "assets/images/taro/taroCard.png",
                  width: 64.75,
                  height: 108.28,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
