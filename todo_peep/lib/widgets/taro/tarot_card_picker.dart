// import 'package:flutter/material.dart';

// class TarotCardPicker extends StatelessWidget {
//   final List<String> cards = [
//     'assets/card1.png',
//     'assets/card2.png',
//     'assets/card3.png',
//     // 추가 카드 이미지 경로
//   ];

//   const TarotCardPicker({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SizedBox(
//         width: 300,
//         height: 300,
//         child: Stack(
//           children: _buildCardWidgets(),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildCardWidgets() {
//     const double radius = 150;
//     final double angleStep = 360 / cards.length;
//     final List<Widget> cardWidgets = [];

//     for (int i = 0; i < cards.length; i++) {
//       final double angle = i * angleStep * (pi / 180);
//       final double x = radius * cos(angle) + radius;
//       final double y = radius * sin(angle) + radius;

//       cardWidgets.add(
//         Positioned(
//           left: x - 30, // 카드의 너비에 따라 조정
//           top: y - 45, // 카드의 높이에 따라 조정
//           child: GestureDetector(
//             onTap: () {
//               print('Card ${i + 1} selected');
//             },
//             child: Image.asset(
//               cards[i],
//               width: 60, // 카드의 너비
//               height: 90, // 카드의 높이
//             ),
//           ),
//         ),
//       );
//     }

//     return cardWidgets;
//   }
// }
