import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';
import 'package:todo_peep/widgets/taro/render_card.dart';
import 'package:todo_peep/widgets/taro/taro_card_select.dart';

class SelectTaro extends StatefulWidget {
  const SelectTaro({super.key});

  @override
  State<SelectTaro> createState() => _SelectTaroState();
}

class _SelectTaroState extends State<SelectTaro> with TickerProviderStateMixin {
  final TaroController controller = Get.put(TaroController());
  double _rotation = 0.0; // 초기 회전 값
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  late AnimationController _moveController;
  late Animation<double> _moveAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  bool isVisible = false; // 초기 상태를 false로 설정

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _rotationAnimation =
        Tween<double>(begin: 0, end: 0).animate(_rotationController)
          ..addListener(() {
            setState(() {
              _rotation = _rotationAnimation.value;
            });
          });

    _moveController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _moveAnimation = Tween<double>(begin: -40.0, end: -70.0).animate(
      CurvedAnimation(
        parent: _moveController,
        curve: Curves.easeInOut,
      ),
    );

    controller.animation(false);

    _scaleController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _moveController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // 스와이프 거리(속도)에 따라 회전 값을 변경
      _rotation += details.delta.dx * 0.01;
    });
  }

  void resetRotationAndSelect() {
    _rotationAnimation =
        Tween<double>(begin: _rotation, end: 0).animate(_rotationController);

    _rotationController.forward(from: 0).whenComplete(() {
      print("회전 애니메이션 끝 move card");
      setState(() {
        // 회전 후 이동 애니메이션 시작
        isVisible = true; // 가시성 변경
      });
      _moveController.forward();

      // 이동 애니메이션이 완료된 후, 크기 확대 애니메이션 시작
      _moveController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scaleController.forward(); // 이동이 끝나면 크기 확대 애니메이션 실행
        }
      });
      _scaleController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("animation end");
          controller.animation(true);
          Future.delayed(const Duration(seconds: 3), () {
            resetAnimations();
          });
        }
      });
    });
  }

  void resetAnimations() {
    if (controller.animation == false.obs) {
// 애니메이션을 초기 상태로 되돌림
      _rotationController.reset();
      _moveController.reset();
      _scaleController.reset();

      // 애니메이션이 반복될 수 있도록 상태 초기화
      setState(() {
        isVisible = false;
        controller.animation(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var radius = screenWidth * 0.3; // 반지름을 0.5 * screenWidth로 변경
    var cardCount = 20; // 카드의 개수
    var centerX = (screenWidth - 58) / 2; // 화면 중심의 X 좌표
    var centerY = (screenWidth - 58) / 2; // 화면 중심의 Y 좌표

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  GestureDetector(
                    onHorizontalDragUpdate:
                        _onHorizontalDragUpdate, // 스와이프 동작 감지
                    child: Stack(
                      children: [
                        ClipRect(
                          // 컨테이너의 절반만 보이도록 클리핑
                          child: Align(
                            alignment: Alignment.topCenter, // 위쪽 절반만 보이도록 설정
                            heightFactor: 0.5, // 컨테이너의 높이를 절반으로 제한
                            child: Column(
                              children: [
                                Transform.rotate(
                                  angle: _rotation, // 회전 각도 적용
                                  child: SizedBox(
                                    width: screenWidth - 58,
                                    height: screenWidth - 58,
                                    child: Stack(
                                      children: [
                                        for (int i = 0; i < cardCount; i++)
                                          Transform.translate(
                                            // 카드가 원의 중심에서 벗어나도록 offset 조정
                                            offset: Offset(
                                                radius *
                                                        cos(2 *
                                                            pi *
                                                            i /
                                                            cardCount) +
                                                    centerX -
                                                    32.375,
                                                radius *
                                                        sin(2 *
                                                            pi *
                                                            i /
                                                            cardCount) +
                                                    centerY -
                                                    54.14 // Y 좌표 이동
                                                ),
                                            child: Transform.rotate(
                                              angle: 2 * pi * i / cardCount +
                                                  pi / 2, // 각도를 따라 카드 회전
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (controller.loveFortune ==
                                                          true.obs &&
                                                      controller.studyFortune ==
                                                          true.obs &&
                                                      controller
                                                              .wealthFortune ==
                                                          true.obs) {
                                                    return;
                                                  }
                                                  if (isVisible == true) {
                                                    return;
                                                  }
                                                  resetRotationAndSelect();
                                                  controller.selectTaroCard();
                                                },
                                                child: i == 15
                                                    ? Opacity(
                                                        opacity:
                                                            isVisible ? 0 : 1,
                                                        child: Image.asset(
                                                          "assets/images/taro/taroCard.png",
                                                          width: 64.75,
                                                          height: 108.28,
                                                        ),
                                                      )
                                                    : Image.asset(
                                                        "assets/images/taro/taroCard.png",
                                                        width: 64.75,
                                                        height: 108.28,
                                                      ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _moveController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: isVisible ? 1 : 0,
                              child: Transform.translate(
                                offset: Offset(
                                  (screenWidth / 2) - 32.375,
                                  _moveAnimation.value,
                                ),
                                child: AnimatedBuilder(
                                  animation: _scaleController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _scaleAnimation.value,
                                      child: controller.animation == false.obs
                                          ? Image.asset(
                                              "assets/images/taro/taroCard.png",
                                              width: 64.75,
                                              height: 108.28,
                                            )
                                          : const RenderCard(),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.loveFortune != true.obs
                            ? SizedBox(
                                width: 92,
                                height: 156,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: const Color(0xffbcbcbc),
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
                        SizedBox(
                          width: 92,
                          height: 156,
                          child: controller.wealthFortune != true.obs
                              ? DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: const Color(0xffbcbcbc),
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
                        SizedBox(
                          width: 92,
                          height: 156,
                          child: controller.studyFortune != true.obs
                              ? DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(5),
                                  dashPattern: const [6, 3],
                                  color: const Color(0xffbcbcbc),
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
                      ],
                    ),
                  ),
                  Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 29),
                    padding: const EdgeInsets.fromLTRB(29, 0, 29, 0),
                    child: SizedBox(
                      width: screenWidth,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 156,
                            height: 37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xff808080),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (isVisible == false) {
                                  controller.changeRandomCard();
                                }
                              },
                              child: const Text(
                                "다시 선택",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff808080),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 156,
                            height: 37,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff424656),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                if (controller.loveFortune == true.obs &&
                                    controller.wealthFortune == true.obs &&
                                    controller.studyFortune == true.obs) {
                                  await controller.mistralTaroResult();
                                  //print(controller.taroResult[2]);
                                  Get.toNamed(
                                    "/taro/result",
                                    arguments: {
                                      'taroResult': controller.taroResult,
                                      'selectCard': controller.selectedCards,
                                    },
                                  );
                                }
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
