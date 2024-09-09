import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamDetail extends StatelessWidget {
  const TeamDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    final Map<String, dynamic> teamData = Get.arguments as Map<String, dynamic>;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await Get.toNamed("/team");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfff4f4f4),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xfff4f4f4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  "${teamData['teamName']}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: (screenWidth - 68) / 2,
                      height: 64,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "종료날짜",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffb6b6b6),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${teamData['endDate']}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: (screenWidth - 68) / 2,
                      height: 64,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "종료날짜",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffb6b6b6),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${teamData['endDate']}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  "프로젝트 설명",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb6b6b6),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(right: 29),
                  child: Text(
                    "${teamData['description']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "프로젝트 팀원",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb6b6b6),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(0, 0),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 126, 119, 98),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(-20, 0),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Task List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/team/detail/viewAll");
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffcfcfcf),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
