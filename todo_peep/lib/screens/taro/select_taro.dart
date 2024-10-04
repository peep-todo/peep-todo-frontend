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

class _SelectTaroState extends State<SelectTaro> with TickerProviderStateMixin {
  final TaroController controller = Get.put(TaroController());
  Offset _position = const Offset(0, 0);
  double _rotation = 0.0; // 초기 회전 값
  late AnimationController _rotationController;
  late AnimationController _moveController;
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _moveAnimation;

  final GlobalKey _containerKey = GlobalKey();
  final GlobalKey _cardKey = GlobalKey();
  late RenderBox renderContainerBox;
  late RenderBox renderCardBox;
  late Offset localContainerPosition;
  late Offset localCardPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderContainerBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      localContainerPosition =
          renderContainerBox.localToGlobal(Offset.zero); // 현재 위치 얻기
      print("renderContainerBox: $localContainerPosition");

      renderCardBox = _cardKey.currentContext!.findRenderObject() as RenderBox;
      localCardPosition = renderCardBox.localToGlobal(Offset.zero); // 현재 위치 얻기
      print("renderCardBox: $localCardPosition");
    });

    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 300), // 회전 애니메이션 시간
      vsync: this,
    );

    _moveController = AnimationController(
      duration: const Duration(milliseconds: 500), // 이동 애니메이션 시간
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.0).animate(_rotationController)
          ..addListener(() {
            setState(() {
              _rotation = _rotationAnimation.value;
            });
          });

    // 애니메이션이 변경될 때마다 UI를 업데이트하는 리스너 설정
    _moveAnimation =
        Tween<Offset>(begin: _position, end: _position).animate(_moveController)
          ..addListener(() {
            setState(() {
              _position = _moveAnimation.value;
              print("Position updated: $_position");
            });
          });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _moveController.dispose();
    super.dispose();
  }

  void _resetRotationAndMove() {
    _rotationAnimation =
        Tween<double>(begin: _rotation, end: 0.0).animate(_rotationController);

    _rotationController.forward(from: 0.0).then((_) {
      // 회전 애니메이션 완료 후 이동 애니메이션 시작
      // _updatePosition(); // 위치 업데이트
      // _moveController.forward(from: 0.0);
      print("회전 완료 후 이동 시작");
      printOffset();
    });
  }

  void printOffset() {
    // 현재 위치에서 목표 위치로 이동하는 애니메이션 설정
    _moveAnimation =
        Tween<Offset>(begin: localCardPosition, end: localContainerPosition)
            .animate(_moveController);

    // 이동 애니메이션 시작
    _moveController.forward(from: 0.0);
  }

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
                  Visibility(
                    visible: false, // false로 설정하여 위젯을 숨깁니다.
                    maintainSize: false,
                    child: Container(
                      key: _cardKey,
                      color: const Color.fromARGB(248, 146, 16, 16),
                      width: 64.75,
                      height: 108.28,
                    ),
                  ),
                  GestureDetector(
                    onHorizontalDragUpdate:
                        _onHorizontalDragUpdate, // 스와이프 동작 감지
                    child: ClipRect(
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
                                          radius * cos(2 * pi * i / cardCount) +
                                              centerX -
                                              32.375, // X 좌표 이동
                                          radius * sin(2 * pi * i / cardCount) +
                                              centerY -
                                              54.14, // Y 좌표 이동
                                        ),
                                        child: Transform.rotate(
                                          angle: 2 * pi * i / cardCount +
                                              pi / 2, // 각도를 따라 카드 회전
                                          child: GestureDetector(
                                            onTap: () {
                                              _resetRotationAndMove();

                                              // controller.selectTaroCard();
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
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
                          key: _containerKey,
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
                              onPressed: () {},
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
