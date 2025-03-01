import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaroResult extends StatelessWidget {
  const TaroResult({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var arguments = Get.arguments;
    var taroResult = arguments['taroResult']; // 타로 결과 값
    var selectCard = arguments['selectCard']; // 선택된 카드들

    return Scaffold(
      appBar: AppBar(
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
              onPressed: () {},
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
