import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_peep/controllers/detail_task_controller.dart';
import 'package:todo_peep/widgets/team/select_date.dart';
import 'package:todo_peep/widgets/detail/select_time.dart';

class AddScheduleDetaillist extends GetView<DetailTaskController> {
  AddScheduleDetaillist({super.key});

  final List<String> items = ['frontend', 'backend', 'design'];
  final timeController = Get.find<TimeController>();

  final TextEditingController scheduleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    var strToday = formatter.format(now);
    return strToday;
  }

  String? getTime() {
    return '없음';
  }

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
          // TimeController 초기화
          timeController.startTime.value = '없음';
          timeController.endTime.value = '없음';
          timeController.startTimeTextController.text = '없음';
          timeController.endTimeTextController.text = '없음';

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
                  // TimeController 초기화
                  timeController.startTime.value = '없음';
                  timeController.endTime.value = '없음';
                  timeController.startTimeTextController.text = '없음';
                  timeController.endTimeTextController.text = '없음';
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
                          onTap: () {
                            controller.onCategoryPinToggle();
                            if (controller.categoryPin.value) {
                              controller.isRoutine.value = false;
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: controller.categoryPin.value
                                    ? const Color(0xff424656)
                                    : const Color(0xffD1D1D6),
                                width: 1,
                              ),
                              color: controller.categoryPin.value
                                  ? const Color(0xff424656)
                                  : Colors.white,
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
                    Obx(() {
                      if (!controller.isRoutine.value) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✔ 당일 일정 체크박스

                              // ✔ 조건부 분기: 당일 일정 체크 여부에 따라 다르게 UI 출력
                              controller.categoryPin.value
                                  ? Row(
                                      children: [
                                        // 시작 시간
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                child: Obx(() => TextFormField(
                                                      controller: timeController
                                                          .startTimeTextController,
                                                      style: const TextStyle(
                                                        // ✅ 이거 추가!!
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(left: 16),
                                                        suffixIcon: const Icon(
                                                          Icons.access_time,
                                                          size: 20,
                                                          color:
                                                              Color(0xffcfcfcf),
                                                        ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                                0xffF4F4F4)
                                                            .withOpacity(0.5),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        hintText: timeController
                                                                .startTime
                                                                .value
                                                                .isEmpty
                                                            ? getTime()
                                                            : timeController
                                                                .startTime
                                                                .value,
                                                        hintStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      readOnly: true,
                                                      onTap: () {
                                                        timeController
                                                            .showTimePicker(
                                                                context,
                                                                isStart: true);
                                                      },
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        // 종료 시간
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                child: Obx(() => TextFormField(
                                                      controller: timeController
                                                          .endTimeTextController,
                                                      style: const TextStyle(
                                                        // ✅ 이거 추가!!
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(left: 16),
                                                        suffixIcon: const Icon(
                                                          Icons.access_time,
                                                          size: 20,
                                                          color:
                                                              Color(0xffcfcfcf),
                                                        ),
                                                        filled: true,
                                                        fillColor: const Color(
                                                                0xffF4F4F4)
                                                            .withOpacity(0.5),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        hintText: timeController
                                                                .endTime
                                                                .value
                                                                .isEmpty
                                                            ? getTime()
                                                            : timeController
                                                                .endTime.value,
                                                        hintStyle:
                                                            const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                      readOnly: true,
                                                      onTap: () {
                                                        timeController
                                                            .showTimePicker(
                                                                context,
                                                                isStart: false);
                                                      },
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(children: [
                                      // 시작 날짜 + 시작 시간
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      suffixIcon: const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 20,
                                                        color:
                                                            Color(0xffcfcfcf),
                                                      ),
                                                      filled: true,
                                                      fillColor: const Color(
                                                              0xffF4F4F4)
                                                          .withOpacity(0.5),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      hintText:
                                                          controller.end ==
                                                                  ''.obs
                                                              ? getToday()
                                                              : controller.end
                                                                  .toString(),
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                    readOnly: true,
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.white,
                                                        isScrollControlled:
                                                            false,
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        context: context,
                                                        builder: (context) {
                                                          return SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                20,
                                                            height: 452,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20),
                                                              child: SelectDate(
                                                                startDate:
                                                                    controller
                                                                        .start
                                                                        .toString(),
                                                                endDate: controller
                                                                    .end
                                                                    .toString(),
                                                                onDateRangeSelected:
                                                                    controller
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
                                          // 시작 시간 (같은거)
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  child: Obx(() =>
                                                      TextFormField(
                                                        controller: timeController
                                                            .startTimeTextController,
                                                        style: const TextStyle(
                                                          // ✅ 이거 추가!!
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16),
                                                          suffixIcon:
                                                              const Icon(
                                                            Icons.access_time,
                                                            size: 20,
                                                            color: Color(
                                                                0xffcfcfcf),
                                                          ),
                                                          filled: true,
                                                          fillColor: const Color(
                                                                  0xffF4F4F4)
                                                              .withOpacity(0.5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          hintText: timeController
                                                                  .startTime
                                                                  .value
                                                                  .isEmpty
                                                              ? getTime()
                                                              : timeController
                                                                  .startTime
                                                                  .value,
                                                          hintStyle:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                        readOnly: true,
                                                        onTap: () {
                                                          timeController
                                                              .showTimePicker(
                                                                  context,
                                                                  isStart:
                                                                      true);
                                                        },
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 20),

                                      // 종료 날짜 + 종료 시간
                                      Row(children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                        const EdgeInsets.only(
                                                            left: 16),
                                                    suffixIcon: const Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      size: 20,
                                                      color: Color(0xffcfcfcf),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xffF4F4F4)
                                                            .withOpacity(0.5),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none,
                                                    ),
                                                    hintText:
                                                        controller.end == ''.obs
                                                            ? getToday()
                                                            : controller.end
                                                                .toString(),
                                                    hintStyle: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                  readOnly: true,
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.white,
                                                      isScrollControlled: false,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        20)),
                                                      ),
                                                      context: context,
                                                      builder: (context) {
                                                        return SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              20,
                                                          height: 452,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: SelectDate(
                                                              startDate:
                                                                  controller
                                                                      .start
                                                                      .toString(),
                                                              endDate: controller
                                                                  .end
                                                                  .toString(),
                                                              onDateRangeSelected:
                                                                  controller
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
                                        // 종료 시간
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                  child: Obx(() =>
                                                      TextFormField(
                                                        controller: timeController
                                                            .endTimeTextController,
                                                        style: const TextStyle(
                                                          // ✅ 이거 추가!!
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 16),
                                                          suffixIcon:
                                                              const Icon(
                                                            Icons.access_time,
                                                            size: 20,
                                                            color: Color(
                                                                0xffcfcfcf),
                                                          ),
                                                          filled: true,
                                                          fillColor: const Color(
                                                                  0xffF4F4F4)
                                                              .withOpacity(0.5),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                BorderSide.none,
                                                          ),
                                                          hintText: timeController
                                                                  .endTime
                                                                  .value
                                                                  .isEmpty
                                                              ? getTime()
                                                              : timeController
                                                                  .endTime
                                                                  .value,
                                                          hintStyle:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                        ),
                                                        readOnly: true,
                                                        onTap: () {
                                                          timeController
                                                              .showTimePicker(
                                                                  context,
                                                                  isStart:
                                                                      false);
                                                        },
                                                      )),
                                                ),
                                              ]),
                                        ), // Row 닫는 괄호
                                      ]), // Column 닫는 괄호
                                    ])
                            ]); // Column 전체 return 세미콜론 (굉장히 중요)
                      } else {
                        return const SizedBox();
                      }
                    }), // Obx 닫기
                    const SizedBox(height: 15),

                    // 루틴 설정
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isRoutine.value =
                                !controller.isRoutine.value;
                            if (controller.isRoutine.value) {
                              controller.categoryPin.value = false; // 당일 일정 해제
                            }
                          },
                          child: Obx(() => Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: controller.isRoutine.value
                                        ? const Color(0xff424656)
                                        : const Color(0xffD1D1D6),
                                    width: 1,
                                  ),
                                  color: controller.isRoutine.value
                                      ? const Color(0xff424656)
                                      : Colors.white,
                                ),
                                child: controller.isRoutine.value
                                    ? const Icon(Icons.check,
                                        size: 18, color: Colors.white)
                                    : null,
                              )),
                        ),
                        const SizedBox(width: 8),
                        const Text("루틴으로 설정하기",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff525252))),
                      ],
                    ),

                    Obx(() => controller.isRoutine.value
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  // 시작 날짜
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "시작 날짜",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff808080),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        SizedBox(
                                          height: 50,
                                          child: TextFormField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 16),
                                              suffixIcon: const Icon(
                                                Icons.calendar_month_outlined,
                                                size: 20,
                                                color: Color(0xffcfcfcf),
                                              ),
                                              filled: true,
                                              fillColor: const Color(0xffF4F4F4)
                                                  .withOpacity(0.5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: controller.start ==
                                                      ''.obs
                                                  ? getToday()
                                                  : controller.start.toString(),
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                isScrollControlled: false,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20,
                                                    height: 452,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: SelectDate(
                                                        startDate: controller
                                                            .start
                                                            .toString(),
                                                        endDate: controller.end
                                                            .toString(),
                                                        onDateRangeSelected:
                                                            controller
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
                                  // 종료 날짜
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "종료 날짜",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff808080),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        SizedBox(
                                          height: 50,
                                          child: TextFormField(
                                            controller: dateController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 16),
                                              suffixIcon: const Icon(
                                                Icons.calendar_month_outlined,
                                                size: 20,
                                                color: Color(0xffcfcfcf),
                                              ),
                                              filled: true,
                                              fillColor: const Color(0xffF4F4F4)
                                                  .withOpacity(0.5),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: controller.end == ''.obs
                                                  ? getToday()
                                                  : controller.end.toString(),
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                            readOnly: true,
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor: Colors.white,
                                                isScrollControlled: false,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            20,
                                                    height: 452,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: SelectDate(
                                                        startDate: controller
                                                            .start
                                                            .toString(),
                                                        endDate: controller.end
                                                            .toString(),
                                                        onDateRangeSelected:
                                                            controller
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
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  // 반복 주기
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "반복 주기",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff808080),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffF4F4F4)
                                                .withOpacity(0.5),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              hint: const Text(
                                                '선택하기',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xffcfcfcf)),
                                              ),
                                              items: ['매일', '매주', '매월', '매년']
                                                  .map((String item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(item,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                      ))
                                                  .toList(),
                                              value: controller
                                                      .repeatCycle.value.isEmpty
                                                  ? null
                                                  : controller
                                                      .repeatCycle.value,
                                              onChanged: (String? value) {
                                                controller.repeatCycle.value =
                                                    value!;
                                              },
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Color(0xffcfcfcf)),
                                              ),
                                              buttonStyleData:
                                                  const ButtonStyleData(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                height: 50,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // 시작 시간
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "시작 시간",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff808080),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        SizedBox(
                                          height: 50,
                                          child: Obx(() => TextFormField(
                                                controller: timeController
                                                    .startTimeTextController,
                                                style: const TextStyle(
                                                  // ✅ 이거 추가!!
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff000000),
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  suffixIcon: const Icon(
                                                    Icons.access_time,
                                                    size: 20,
                                                    color: Color(0xffcfcfcf),
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xffF4F4F4)
                                                          .withOpacity(0.5),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  hintText: timeController
                                                          .startTime
                                                          .value
                                                          .isEmpty
                                                      ? getTime()
                                                      : timeController
                                                          .startTime.value,
                                                  hintStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                readOnly: true,
                                                onTap: () {
                                                  timeController.showTimePicker(
                                                      context,
                                                      isStart: true);
                                                },
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        : const SizedBox()),
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
