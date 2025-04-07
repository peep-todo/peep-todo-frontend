import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_peep/controllers/detail_task_controller.dart';
import 'package:todo_peep/widgets/team/select_date.dart';

class AddScheduleDetaillist extends GetView<DetailTaskController> {
  AddScheduleDetaillist({super.key});

  final List<String> items = ['frontend', 'backend', 'design'];

  String? getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(now);
    return strToday;
  }

  final TextEditingController scheduleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // void _showTimePicker(BuildContext context) async {
  //   TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );

  //   if (pickedTime != null) {
  //     // 선택한 시간을 컨트롤러에 반영
  //     controller.startTime.value = pickedTime.format(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    if (Get.isRegistered<DetailTaskController>()) {
      Get.delete<DetailTaskController>();
    }
    Get.put(DetailTaskController());

    return Obx(() {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async {
          await Get.toNamed("/DetailList");
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
                  await Get.toNamed("/DetailList"); // onWillPop과 동일한 동작
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
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: controller.onCategoryPinToggle,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle, // 체크박스 모양 (사각형)
                              borderRadius: BorderRadius.circular(5), // 모서리 둥글기
                              border: Border.all(
                                color: controller.categoryPin.value
                                    ? const Color(0xff424656)
                                    : const Color(
                                        0xffD1D1D6), // 체크 여부에 따른 테두리 색상
                                width: 1,
                              ),
                              color: controller.categoryPin.value
                                  ? const Color(0xff424656)
                                  : Colors.white, // 체크 여부에 따른 배경색
                            ),
                            child: controller.categoryPin.value
                                ? const Icon(Icons.check,
                                    size: 18, color: Colors.white)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "당일 일정",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff525252),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
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
                                    hintStyle: const TextStyle(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          height: 452,
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
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "시작 시간",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff808080),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),
                                    suffixIcon: const Icon(
                                      Icons.access_time,
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
                                    hintText: controller.startTime.value.isEmpty
                                        ? "00:00"
                                        : controller.startTime.value,
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    controller.showTimePicker(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
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
                                    hintStyle: const TextStyle(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              20,
                                          height: 452,
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
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10), // 종료 날짜와 종료 시간 간격
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "종료 시간",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff808080),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),
                                    suffixIcon: const Icon(
                                      Icons.access_time,
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
                                    hintText: controller.endTime.value.isEmpty
                                        ? "00:00"
                                        : controller.endTime.value,
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () {
                                    controller
                                        .showEndTimePicker(context); // 종료 시간 선택
                                  },
                                ),
                              ),
                            ],
                          ),
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
