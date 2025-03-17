import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/bottom_nav_controller.dart';

class TaroResult extends StatelessWidget {
  TaroResult({super.key});
  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    //var screenHeight = MediaQuery.of(context).size.height;
    var arguments = Get.arguments;
    var taroResult = arguments['taroResult']; // 타로 결과 값
    var selectCard = arguments['selectCard']; // 선택된 카드들

    return Scaffold(
      appBar: AppBar(
        //뒤로가기 버튼 제거
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFf4f4f4),
        title: const Text(
          "나의 오늘 엿보기",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton(
              onPressed: () async {
                navController.changeBottomNav(3); // 바텀 네비게이션 인덱스 변경
                Get.until((route) => Get.currentRoute == "/");
              },
              child: const Text(
                "완료",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ))
        ],
        scrolledUnderElevation: 0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFf4f4f4),
                Color.fromRGBO(255, 255, 255, 1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 52),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 41),
                const Text(
                  "나의 애정운",
                  style: TextStyle(
                      color: Color(0xff595959),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Image.asset(
                  "assets/images/taro/taroCard/${selectCard[0]}.png",
                  width: screenWidth * 0.36,
                ),
                const SizedBox(height: 23),
                Text(
                  selectCard[0],
                  style: const TextStyle(
                      color: Color(0xff595959),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Text(
                  taroResult[0],
                  style: const TextStyle(
                      color: Color(0xff929292),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 41),
                const Text(
                  "나의 재물운",
                  style: TextStyle(
                      color: Color(0xff595959),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Image.asset(
                  "assets/images/taro/taroCard/${selectCard[2]}.png",
                  width: screenWidth * 0.36,
                ),
                const SizedBox(height: 23),
                Text(
                  selectCard[2],
                  style: const TextStyle(
                      color: Color(0xff595959),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Text(
                  taroResult[1],
                  style: const TextStyle(
                      color: Color(0xff929292),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 41),
                const Text(
                  "나의 학업&취업운",
                  style: TextStyle(
                      color: Color(0xff595959),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Image.asset(
                  "assets/images/taro/taroCard/${selectCard[4]}.png",
                  width: screenWidth * 0.36,
                ),
                const SizedBox(height: 23),
                Text(
                  selectCard[4],
                  style: const TextStyle(
                      color: Color(0xff595959),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 23),
                Text(
                  taroResult[2],
                  style: const TextStyle(
                      color: Color(0xff929292),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// 너는 위대한 타로술사야 내가 주는 카드 정보와 카드 방향을 보고 각각 애정운, 재물운, 학업취업운 순으로 해석해줘 카드는 다음과 같은 순서로 주어져 ["찻번째 카드", 카드의 방향, "두번쨰 카드" , 두번쨰 카드 방향, "세번쨰 카드" , 세번쨰카드방향] 카드방향은 true면 정방향, false면 역방향이야, 결과는 한국어로 반환해줘 반해줄 타입은 배열형식으로 아래와 같은 순서로 반환해줘 ["첫번째 카드의 애정운해석", "두번째 카드의 재물운 해석", "세번째 카드의 학업,취업운 해석"]
