import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_peep/controllers/team_controller.dart';
import 'package:todo_peep/services/team_service.dart';
import 'package:todo_peep/widgets/team/select_date.dart';
import 'package:get/get.dart';

enum Type { team, personal }

class TeamProjectAdd extends GetView<TeamController> {
  TeamProjectAdd({super.key});

  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(now);
    return strToday;
  }

  late final Map<String, String> teamData;

  void _createTeam() async {
    if (controller.allFinish.value) {
      final teamData = {
        'name': controller.teamName.toString(),
        'projectName': controller.projectName.toString(),
        'description': controller.description.toString(),
        'startDate': controller.start.toString(),
        'endDate': controller.end.toString(),
      };

      try {
        final response =
            await TeamService().createTeamProject(teamData: teamData);

        // 서버 응답에서 resultData 추출
        if (response['resultData'] != null) {
          final data = {
            'teamData': teamData,
            'inviteUrl': response['resultData'],
          };

          Get.toNamed("/team/create", arguments: data);
        } else {
          print("팀 생성 실패: 응답에 resultData가 없습니다.");
        }
      } catch (e) {
        print("팀 생성 실패: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "프로젝트 생성",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    "팀 이름",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextFormField(
                    controller: teamNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: "팀 이름을 입력하세요",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffcfcfcf),
                      ),
                      filled: true,
                      fillColor: const Color(0xfffcfcfc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    onChanged: controller.onTeamNameChanged,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "프로젝트 이름",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextFormField(
                    controller: projectNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: "프로젝트 이름을 입력하세요",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffcfcfcf),
                      ),
                      filled: true,
                      fillColor: const Color(0xfffcfcfc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    onChanged: controller.onProjectNameChanged,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "설명",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                      hintText: "설명을 입력해 주세요",
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffcfcfcf),
                      ),
                      filled: true,
                      fillColor: const Color(0xfffcfcfc),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    onChanged: controller.onDescriptionChanged,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "시작 날짜",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff808080),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.4,
                            height: 50,
                            child: TextFormField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 16),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 20,
                                    color: Color(0xffcfcfcf),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xfffcfcfc),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: controller.start == ''.obs
                                      ? getToday()
                                      : controller.start.toString(),
                                  hintStyle: controller.start == ''.obs
                                      ? const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffcfcfcf),
                                        )
                                      : const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        width: screenWidth - 20,
                                        height: 452, // 원하는 높이로 설정
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: SelectDate(
                                            startDate:
                                                controller.start.toString(),
                                            endDate: controller.end.toString(),
                                            onDateRangeSelected: controller
                                                .handleDateRangeSelected,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "종료 날짜",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff808080),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.4,
                            height: 50,
                            child: TextFormField(
                                controller: dateController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 16),
                                  suffixIcon: const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 20,
                                    color: Color(0xffcfcfcf),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xfffcfcfc),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: controller.end == ''.obs
                                      ? getToday()
                                      : controller.end.toString(),
                                  hintStyle: controller.end == ''.obs
                                      ? const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffcfcfcf),
                                        )
                                      : const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    isScrollControlled: false,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        width: screenWidth - 20,
                                        height: 452, // 원하는 높이로 설정
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: SelectDate(
                                            startDate:
                                                controller.start.toString(),
                                            endDate: controller.end.toString(),
                                            onDateRangeSelected: controller
                                                .handleDateRangeSelected,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(29, 0, 29, 38), // 하단 버튼 패딩 추가
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.allFinish == false.obs
                    ? const Color(0xfff5f5f5)
                    : const Color(0xff424656)),
            child: TextButton(
              //모든 내용이 입력되었을경우 생성완료
              onPressed: _createTeam,
              child: Text(
                "생성하기",
                style: controller.allFinish == false.obs
                    ? const TextStyle(
                        fontSize: 16,
                        color: Color(0xff808080),
                      )
                    : const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
