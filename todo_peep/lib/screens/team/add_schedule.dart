import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_peep/controllers/team_task_controller.dart';
import 'package:todo_peep/widgets/team/select_date.dart';

class AddSchedule extends GetView<TeamTaskController> {
  AddSchedule({super.key});

  final List<String> items = ['frontend', 'backend', 'design'];
  final List<String> assignedTo = ['임유나', '김효진', '최수진'];

  String? getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(now);
    return strToday;
  }

  final TextEditingController scheduleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    if (Get.isRegistered<TeamTaskController>()) {
      Get.delete<TeamTaskController>();
    }
    Get.put(TeamTaskController());

    return Obx(() {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async {
          await Get.toNamed("/team/detail/viewAll");
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "일정 생성",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 24), // 뒤로가기 버튼 패딩 조절
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Get.toNamed(
                      "/team/detail/viewAll"); // onWillPop과 동일한 동작
                },
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  "완료",
                  style: controller.allFinish == true.obs
                      ? const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff424656),
                        )
                      : const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffbcbcbc),
                        ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "카테고리",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff808080),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF4F4F4).withOpacity(0.5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Text(
                            '선택하기',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffcfcfcf),
                            ),
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: controller.category.value.isEmpty
                              ? null
                              : controller.category.value,
                          onChanged: (String? value) {
                            controller.onCategoryChanged(value!);
                          },
                          iconStyleData: const IconStyleData(
                              icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffcfcfcf),
                          )),
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 50,
                            width: screenWidth * 0.3,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 48,
                            padding: EdgeInsets.only(left: 16),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.12),
                                  offset: const Offset(0, 0),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "일정",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff808080),
                      ),
                    ),
                    const SizedBox(height: 3),
                    TextFormField(
                      controller: scheduleController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 16),
                        hintText: "일정을 입력하세요",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffcfcfcf),
                        ),
                        filled: true,
                        fillColor: const Color(0xffF4F4F4).withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      onChanged: controller.onScheduleChanged,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "담당자",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff808080),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF4F4F4).withOpacity(0.5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Text(
                            '담당자를 지정해주세요',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffcfcfcf),
                            ),
                          ),
                          items: assignedTo
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 169, 164, 150),
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                              .toList(),
                          value: controller.assignedTo.value.isEmpty
                              ? null
                              : controller.assignedTo.value,
                          onChanged: (String? value) {
                            controller.onAssignedToChanged(value!);
                          },
                          iconStyleData: const IconStyleData(
                              icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xffcfcfcf),
                          )),
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 50,
                            width: screenWidth * 0.3,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.12),
                                  offset: const Offset(0, 0),
                                  blurRadius: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
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
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                                    fillColor: const Color(0xffF4F4F4)
                                        .withOpacity(0.5),
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
                                              endDate:
                                                  controller.end.toString(),
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
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
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
                                    fillColor: const Color(0xffF4F4F4)
                                        .withOpacity(0.5),
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
                                              endDate:
                                                  controller.end.toString(),
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
        ),
      );
    });
  }
}
