// import 'dart:math';

// import 'package:flutter/material.dart';

// class Tarocard extends StatelessWidget {
//   const Tarocard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     var cardSize = 60.0;
//     return Scaffold(
//       body: Container(
//         width: screenWidth,
//         height: screenWidth,
//         color: const Color.fromARGB(255, 168, 148, 85),
//         child: const Align(
//             alignment: Alignment.bottomCenter, child: CircularList()),
//       ),
//     );
//   }
// }

// class CircularList extends StatelessWidget {
//   const CircularList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     double cardWidth = 64.75; // 카드의 너비
//     double cardHeight = 108.28; // 카드의 높이
//     double radius = screenWidth / 2; // 카드 높이의 절반을 반지름으로 사용

//     return Stack(
//       children: List.generate(20, (index) {
//         double angle = index * (2 * pi / 20); // 카드의 각도를 계산
//         double xOffset = radius * cos(angle); // 카드의 X 좌표
//         double yOffset = radius * sin(angle); // 카드의 Y 좌표

//         return Positioned(
//           left: 200 + xOffset - cardWidth / 2, // 카드의 X 좌표
//           top: 150 + yOffset - cardHeight / 2, // 카드의 Y 좌표
//           child: SizedBox(
//             width: cardWidth, // 카드의 너비
//             height: cardHeight, // 카드의 높이
//             child: Image.asset("assets/images/taro/taroCard.png"),
//           ),
//         );
//       }),
//     );
//   }
// }
