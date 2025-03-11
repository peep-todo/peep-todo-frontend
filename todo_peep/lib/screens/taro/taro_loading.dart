import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';

class TaroLoading extends StatefulWidget {
  const TaroLoading({super.key});

  @override
  State<TaroLoading> createState() => _TaroLoadingState();
}

class _TaroLoadingState extends State<TaroLoading> {
  final TaroController controller = Get.find<TaroController>();
  //final TaroController controller = Get.put(TaroController());
  double _opacity = 1.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    controller.mistralTaroResult();
    _startFlashing(); // 반짝이는 애니메이션 시작
  }

  // 타이머를 사용하여 이미지 반짝이게 하기
  void _startFlashing() {
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      setState(() {
        // 0과 1 사이에서 투명도를 주기적으로 변경
        _opacity = (_opacity == 1.0) ? 0.0 : 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머가 더 이상 필요 없을 때 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Obx(() {
      // 로딩 상태가 100%가 되면 자동으로 이동
      if (controller.loadingState.toDouble() / 3 >= 1.0) {
        Future.delayed(const Duration(seconds: 2), () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed(
              "/taro/result",
              arguments: {
                'taroResult': controller.taroResult,
                'selectCard': controller.selectedCards,
              },
            );
          });
        });
      }

      //api호출에 실패한 경우
      if (controller.check == false.obs) {
        showErrorDialog();
      }

      return Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xff424656),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 1300),
                curve: Curves.easeIn,
                child: Image.asset(
                  "assets/images/taro/taroLoading.png",
                  width: screenWidth * 1.5,
                  height: screenWidth * 1.5,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "당신의 결과를 불러오는 중입니다.",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFFF4D3),
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: const Color(0xffFFF4D3).withOpacity(0.8),
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: screenWidth * 0.7,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: 0.0, end: controller.loadingState.toDouble() / 3),
                  duration: const Duration(milliseconds: 1500),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: const Color(0xffFFF4D3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xffC8B67E)),
                      minHeight: 8,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<int>(
                tween: IntTween(
                  begin: 0,
                  end: (controller.loadingState.toDouble() / 3 * 100).toInt(),
                ),
                duration: const Duration(milliseconds: 1500),
                builder: (context, value, child) {
                  return Text(
                    "$value%",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xffFFF4D3),
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: const Color(0xffFFF4D3).withOpacity(0.8),
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

bool isDialogOpen = false;

void showErrorDialog() {
  if (!isDialogOpen) {
    // 다이얼로그가 이미 열려 있지 않으면
    isDialogOpen = true; // 다이얼로그 열린 상태로 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 다이얼로그 띄우기
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('너무 많은 요청으로 실패하였습니다. 다시 시도해주세요'),
          actions: [
            TextButton(
              onPressed: () {
                isDialogOpen = false; // 다이얼로그 닫히면 상태 변경
                Get.back(); // 다이얼로그 닫기
                Get.offNamed('/');
              },
              child: const Text('확인'),
            ),
          ],
        ),
        barrierDismissible: false, // 화면 외부 클릭 시 다이얼로그 닫히지 않도록 설정
      );
    });
  }
}
