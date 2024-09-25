import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';
import 'package:todo_peep/widgets/taro/taro_card_select.dart';
import 'package:todo_peep/widgets/taro/tarot_card_circle.dart';

class SelectTaro extends StatefulWidget {
  const SelectTaro({super.key});

  @override
  State<SelectTaro> createState() => _SelectTaroState();
}

class _SelectTaroState extends State<SelectTaro> {
  final TaroController controller = Get.put(TaroController());
  double _rotation = 0.0; // 초기 회전 값

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 스와이프 거리(속도)에 따라 회전 값을 변경
      _rotation += details.delta.dx * 0.01;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Obx(
          () => Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF4F4F4),
                  Color.fromRGBO(255, 255, 255, 1),
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 137),
                const Text(
                  "나의 오늘 엿보기",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff595959),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "${controller.current}을 생각하며 카드를 골라 주세요",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff929292),
                  ),
                ),
                const SizedBox(height: 31),
                Stack(
                  children: [
                    Positioned(
                      child: Transform.rotate(
                        angle: _rotation, // 회전 각도 적용
                        child: SizedBox(
                            width: screenWidth,
                            height: screenWidth,
                            child: const TarotCardCircle()),
                      ),
                    ),
                    Positioned(
                      child: GestureDetector(
                        onHorizontalDragUpdate:
                            _onHorizontalDragUpdate, // 스와이프 동작 감지
                        child: Transform.rotate(
                          angle: _rotation, // 회전 각도 적용
                          child: SizedBox(
                              width: screenWidth,
                              height: screenWidth,
                              child: const TarotCardCircle()),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: screenWidth * 0.45,
                      right: screenWidth * 0.3,
                      child: Image.asset("assets/images/taro/selectTaro.png"),
                    ),
                    Positioned(
                      bottom: screenWidth * 0.55,
                      right: screenWidth * 0.3,
                      child: const Center(
                        child: Text(
                          "카드를 좌우로 이동하며 골라보세요 !",
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xff929292),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenWidth * 0.5,
                      child: Container(
                        width: screenWidth,
                        height: screenWidth,
                        color: const Color.fromARGB(255, 250, 250, 250),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 39),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Transform.translate(
                        offset: Offset(0, -screenWidth * 0.35),
                        child: controller.loveFortune != true.obs
                            ? SizedBox(
                                width: 84,
                                height: 142,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: Colors.black,
                                  child: Container(
                                    color: Colors.white,
                                    child: const Center(
                                      child: Text(
                                        ("애정운"),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff929292),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            : const TaroCardSelect(
                                number: 0,
                              ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -screenWidth * 0.35),
                        child: SizedBox(
                          width: 84,
                          height: 142,
                          child: controller.wealthFortune != true.obs
                              ? DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: Colors.black,
                                  child: Container(
                                    color: Colors.white,
                                    child: const Center(
                                      child: Text(
                                        ("재물운"),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff929292),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const TaroCardSelect(
                                  number: 2,
                                ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -screenWidth * 0.35),
                        child: SizedBox(
                          width: 84,
                          height: 142,
                          child: controller.studyFortune != true.obs
                              ? DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: Colors.black,
                                  child: Container(
                                    color: Colors.white,
                                    child: const Center(
                                      child: Text(
                                        ("학업&취업운"),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff929292),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const TaroCardSelect(
                                  number: 4,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -screenWidth * 0.25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    child: SizedBox(
                      width: screenWidth,
                      height: 40,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 156,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.changeRandomCard();
                                    },
                                    child: const Text(
                                      "다시 선택",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 156,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      print("asdf");
                                    },
                                    child: const Text(
                                      "결과 보기",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
