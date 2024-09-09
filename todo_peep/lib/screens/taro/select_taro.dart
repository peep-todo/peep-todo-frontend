import 'package:flutter/material.dart';

class SelectTaro extends StatelessWidget {
  const SelectTaro({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const Text(
                "애정운을 생각하며 카드를 골라 주세요.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff929292),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                  width: screenWidth,
                  height: 220,
                  color: Colors.amber,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            double xOffset;
                            double yOffset;

                            if (index <= 35) {
                              xOffset =
                                  (screenWidth / 2 - 32) + (36 - index) * 30;
                              yOffset = (36 - index) * 15;
                            } else {
                              xOffset =
                                  (screenWidth / 2 - 32) + (36 - index) * 30;
                              yOffset = (36 - index) * -15;
                            }

                            return Positioned(
                              left: xOffset,
                              top: yOffset,
                              child: SizedBox(
                                width: 64, // 카드의 너비
                                height: 108, // 카드의 높이
                                child: Image.asset(
                                    "assets/images/taro/taroCard.png"),
                              ),
                            );
                          },
                          childCount: 72,
                        ),
                      ),
                    ],
                  )

                  //  Stack(
                  //   children: List.generate(72, (index) {
                  //     double offset = index + 1;
                  //     if (index <= 35) {
                  //       return Positioned(
                  //         left: (screenWidth / 2 - 32) +
                  //             (36 - index) * 30, // 카드의 X 좌표
                  //         top: (36 - index) * 15, // 카드의 Y 좌표
                  //         child: SizedBox(
                  //             width: 64, // 카드의 너비
                  //             height: 108, // 카드의 높이
                  //             child:
                  //                 Image.asset("assets/images/taro/taroCard.png")),
                  //       );
                  //     } else {
                  //       return Positioned(
                  //         left: (screenWidth / 2 - 32) +
                  //             (36 - index) * 30, // 카드의 X 좌표
                  //         top: (36 - index) * -15, // 카드의 Y 좌표
                  //         child: SizedBox(
                  //             width: 64, // 카드의 너비
                  //             height: 108, // 카드의 높이
                  //             child:
                  //                 Image.asset("assets/images/taro/taroCard.png")),
                  //       );
                  //     }
                  //   }),
                  // ),
                  ),
            ]),
      ),
    );
  }
}
