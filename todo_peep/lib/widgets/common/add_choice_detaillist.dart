import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddChoiceDetaillist extends StatelessWidget {
  const AddChoiceDetaillist({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xffE5E8EB),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
          SizedBox(
            width: screenWidth,
            height: 97 + ((screenWidth - 94) / 3) - 32,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "무엇을 생성할까요?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/detaillist/detail/category");
                      },
                      child: Container(
                        width: (screenWidth - 94) / 3,
                        height: (screenWidth - 94) / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xfff4f4f4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/images/add_choice/category.svg"),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "카테고리",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff424656),
                              ),
                            ),
                            const Text(
                              "생성하기",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff424656),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/detaillist/detail/schedule");
                      },
                      child: Container(
                        width: (screenWidth - 94) / 3,
                        height: (screenWidth - 94) / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xfff4f4f4),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/images/add_choice/schedule.svg"),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "일정",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff424656),
                              ),
                            ),
                            const Text(
                              "생성하기",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff424656),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: (screenWidth - 94) / 3,
                      height: (screenWidth - 94) / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xfff4f4f4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              "assets/images/add_choice/friends.svg"),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text(
                            "친구랑",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff424656),
                            ),
                          ),
                          const Text(
                            "약속잡기",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff424656),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
