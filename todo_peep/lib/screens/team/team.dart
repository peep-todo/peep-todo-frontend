import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/team_controller.dart';
import 'package:todo_peep/widgets/team/team_project.dart';

class Team extends GetView<TeamController> {
  Team({super.key});

  //아마 디비에서 모두보기, 진행중, 완료된 에서의 팀이름등의 정보를 전달
  final List<Map<String, dynamic>> all = [
    {
      "name": "모두보기1",
      "teamName": "베포가즈앗1",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 2.0
    },
    {
      "name": "모두보기2",
      "teamName": "베포가즈앗2",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 5.0
    },
    {
      "name": "베포 가즈앗",
      "teamName": "베포가즈앗3",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 1.0,
    },
  ];
  final List<Map<String, dynamic>> process = [
    {
      "name": "진행중1",
      "teamName": "베포가즈앗",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 2.0
    },
    {
      "name": "진행중2",
      "teamName": "베포가즈앗",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 2.0
    },
  ];
  final List<Map<String, dynamic>> finish = [
    {
      "name": "완료된",
      "teamName": "베포가즈앗",
      "endDate": "8월 25일, 2024",
      "remainTask": 28,
      "description": "김효진과 임유나와 최수진과 이예빈이 함께 베포하기 위해서 만드는 웹",
      "member": "",
      "totalValue": 10.0,
      "complete": 2.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    Get.put(TeamController());

    return Obx(
      () => Scaffold(
        body: Container(
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
            padding: const EdgeInsets.fromLTRB(29, 70, 29, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "2024년 8월 24일",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff929292),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "나의 프로젝트",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff595959),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed("/team/add");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: Colors.white,
                        minimumSize: const Size(63, 33),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text(
                        "+ Add",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      // 선택된 박스가 이동하는 애니메이션
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        left: controller.select.value == 1
                            ? 0
                            : controller.select.value == 2
                                ? (screenWidth - 64) / 3
                                : ((screenWidth - 64) / 3) * 2,
                        child: Container(
                          width: (screenWidth - 64) / 3,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xff424656),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildOption(
                            label: "모두 보기",
                            index: 1,
                            controller: controller,
                            width: (screenWidth - 64) / 3,
                          ),
                          _buildOption(
                            label: "진행중",
                            index: 2,
                            controller: controller,
                            width: (screenWidth - 64) / 3,
                          ),
                          _buildOption(
                            label: "완료된",
                            index: 3,
                            controller: controller,
                            width: (screenWidth - 64) / 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (Map<String, dynamic> team
                            in controller.select.value == 1
                                ? all
                                : controller.select.value == 2
                                    ? process
                                    : finish)
                          TeamProject(teamData: team),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required int index,
    required TeamController controller,
    required width,
  }) {
    return GestureDetector(
      onTap: () {
        controller.select(index);
      },
      child: SizedBox(
        width: width,
        height: 44,
        child: Center(
          child: Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: controller.select.value == index ? 1.0 : 0.5,
              child: Text(
                label,
                style: TextStyle(
                  color: controller.select.value == index
                      ? Colors.white
                      : const Color(0xffCFCFCF),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
