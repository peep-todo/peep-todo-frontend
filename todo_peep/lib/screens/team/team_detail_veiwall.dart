import 'package:flutter/material.dart';
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
    return Scaffold(
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
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(20)),
                          ),
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              width: screenWidth - 20,
                              height: screenHeight * 0.28, // 원하는 높이로 설정
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: AddChoice(),
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
                                size: 8,
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
    );
  }
}
