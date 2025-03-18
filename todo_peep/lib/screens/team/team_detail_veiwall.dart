import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_peep/widgets/checkbox_componenet.dart';
import 'package:todo_peep/widgets/common/add_choice.dart';

enum Type { team, personal }

// ignore: must_be_immutable
class TeamDetailViewall extends StatelessWidget {
  TeamDetailViewall({super.key});

  List<Map<String, dynamic>> taskData = [
    {
      'category': 'frontend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'startTime': '',
      'endTime': '',
      'color': 'FFB1AC',
      'isChecked': true,
    },
    {
      'category': 'frontend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'FFB1AC',
      'isChecked': false,
      'startTime': '',
      'endTime': '',
    },
    {
      'category': 'design',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'CDE5D5',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'design',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'CDE5D5',
      'isChecked': true,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'backend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'BFC4D7',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'backend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'BFC4D7',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'backend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'BFC4D7',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'backend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'BFC4D7',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
    {
      'category': 'backend',
      'name': '근로',
      'type': Type.team,
      'startDate': '09/08',
      'endDate': '09/22',
      'color': 'BFC4D7',
      'isChecked': false,
      'startTime': '09:00',
      'endTime': '18:00',
    },
  ];

  late String category = "";
  late String name = "";
  late String time = "";
  late bool categoryChanged = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await Get.toNamed("/team/detail");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfffbfbfb),
          scrolledUnderElevation: 0,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24), // 뒤로가기 버튼 패딩 조절
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () async {
                await Get.toNamed("/team/detail");
              },
            ),
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xfffbfbfb),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Task List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 37), // 아래로부터 살짝 띄움
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                      bottom: Radius.circular(20)),
                                  child: Container(
                                    color: Colors.white, // 모달의 배경색
                                    width: screenWidth - 20,
                                    height: 97 + ((screenWidth - 94) / 3),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: AddChoice(), // 모달 내 콘텐츠
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(63, 33),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
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
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (category != taskData[index]['category']) {
                        category = taskData[index]['category'];
                        categoryChanged = true;
                      } else {
                        categoryChanged = false;
                      }
                      if (categoryChanged &&
                          category == taskData[0]['category']) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 15,
                                  color: taskData[index]['color'] != null
                                      ? Color(int.parse(
                                          '0xff${taskData[index]['color']}'))
                                      : Colors.black,
                                ),
                                const SizedBox(width: 10), // 글머리 기호와 텍스트 사이의 간격
                                Text(
                                  taskData[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset(
                                    "assets/images/common/pin.svg",
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            CheckboxComponenet(taskData: taskData[index]),
                          ],
                        );
                      } else if (categoryChanged &&
                          category != taskData[0]['category']) {
                        return Column(
                          children: [
                            const SizedBox(height: 27),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: taskData[index]['color'] != null
                                      ? Color(int.parse(
                                          '0xff${taskData[index]['color']}'))
                                      : Colors.black,
                                ), // 글머리 기호
                                const SizedBox(width: 10), // 글머리 기호와 텍스트 사이의 간격
                                Text(
                                  taskData[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 9),
                            CheckboxComponenet(taskData: taskData[index]),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            const SizedBox(height: 9),
                            CheckboxComponenet(taskData: taskData[index]),
                          ],
                        );
                      }
                    },
                    itemCount: taskData.length,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
