import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/bottom_nav_controller.dart';
import 'package:todo_peep/widgets/checkbox_componenet.dart';

enum Type { team, personal }

class TeamDetail extends StatelessWidget {
  TeamDetail({super.key});
  final BottomNavController navController = Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    //final Map<String, dynamic> teamData = Get.arguments as Map<String, dynamic>;

    final Map<String, dynamic> teamData = {
      'category': '',
      'teamName': "",
      'type': "Type.team",
      'startDate': "controller.start.toString()",
      'endDate': "controller.end.toString()",
      'startTime': '',
      'endTime': '',
      'description': "controller.description.toString()",
      'color': '',
      'isChecked': false,
    };

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

    //final TextEditingController boardAnswerController = TextEditingController();

    //첫번째 카테고리에서 두개의 테스크만 띄워주기
    String taskCategory = taskData[0]['category'];
    List<Map<String, dynamic>> detailTaskData = [];
    if (taskData[1]['category'] == taskCategory) {
      detailTaskData.add(taskData[0]);
      detailTaskData.add(taskData[1]);
    } else {
      detailTaskData.add(taskData[0]);
    }
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        navController.changeBottomNav(2);
        await Get.toNamed("/");
        return true;
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
              onPressed: () {
                Get.back();
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
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "남은 할 일",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffb6b6b6),
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "28개 남았습니다",
                              style: TextStyle(
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
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: detailTaskData[0]['color'] != null
                          ? Color(
                              int.parse('0xff${detailTaskData[0]['color']}'))
                          : Colors.black,
                    ),
                    const SizedBox(width: 10), // 글머리 기호와 텍스트 사이의 간격
                    Text(
                      detailTaskData[0]['category'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: detailTaskData.map((item) {
                    return Column(
                      children: [
                        const SizedBox(height: 9),
                        CheckboxComponenet(taskData: item),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Container(
                  width: screenWidth,
                  height: 1,
                  color: const Color(0xffE7E7E7),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Board",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "get in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffcfcfcf),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: screenWidth,
                  height: 138,
                  child: const Center(
                    child: Text(
                      "보드가 존재하지 않습니다!",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffCFCFCF)),
                    ),
                  ),
                ),

                // 해당 주석 처리 부분은 보드가 있는 경우의 디자인입니다.
                // Container(
                //   width: screenWidth,
                //   height: 138,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     color: Colors.white,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 16, vertical: 16),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: [
                //             Align(
                //               alignment: Alignment.centerLeft,
                //               child: Container(
                //                 width: 38,
                //                 height: 38,
                //                 decoration: BoxDecoration(
                //                   color: const Color.fromARGB(
                //                       255, 250, 250, 250),
                //                   shape: BoxShape.circle,
                //                   border: Border.all(
                //                       color: const Color(0xffCFCFCF)),
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(width: 12),
                //             const Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(
                //                   children: [
                //                     Text(
                //                       "임유나",
                //                       style: TextStyle(
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     SizedBox(width: 5),
                //                     Text(
                //                       "5:05 오후",
                //                       style: TextStyle(
                //                         fontSize: 9,
                //                         fontWeight: FontWeight.w400,
                //                         color: Color(0xff808080),
                //                       ),
                //                     )
                //                   ],
                //                 ),
                //                 Text(
                //                   "다들 오늘 어디까지함?",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 )
                //               ],
                //             )
                //           ],
                //         ),
                //         TextFormField(
                //           controller: boardAnswerController,
                //           decoration: InputDecoration(
                //             contentPadding: const EdgeInsets.only(left: 16),
                //             hintText: "답장을 입력해주세요",
                //             hintStyle: const TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: Color(0xffcfcfcf),
                //             ),
                //             filled: true,
                //             fillColor: const Color(0xffF4F4F4),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(10),
                //               borderSide: BorderSide.none,
                //             ),
                //             suffixIcon: IconButton(
                //               onPressed: () {},
                //               icon: SvgPicture.asset(
                //                   "assets/images/team/send.svg"),
                //             ),
                //           ),
                //           style: const TextStyle(
                //             fontSize: 14,
                //           ),
                //           // onChanged: controller.onCategoryNameChanged,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //const SizedBox(height: 57),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
