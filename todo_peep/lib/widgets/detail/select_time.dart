import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeController extends GetxController {
  var startTime = '없음'.obs;
  var endTime = '없음'.obs;

  final startTimeTextController = TextEditingController();
  final endTimeTextController = TextEditingController();

  void showTimePicker(BuildContext context, {required bool isStart}) {
    showCustomTimePicker(context, isStart: isStart);
  }

  // @override
  // void onInit() {
  //   super.onInit();

  //   startTime.value = '없음';
  //   endTime.value = '없음';

  //   startTimeTextController.text = '없음';
  //   endTimeTextController.text = '없음';
  // }
}

void showCustomTimePicker(BuildContext context, {required bool isStart}) {
  final timeController = Get.find<TimeController>();

  int selectedHour = TimeOfDay.now().hour;
  int selectedMinute = TimeOfDay.now().minute;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 370,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Color(0xffcfcfcf), // <- 너가 쓰던 아이콘 색이랑 똑같이!
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ✅ 회색 배경 + 버튼 너비 동일한 피커 영역
                      Container(
                        width: 332,
                        height: 160,
                        decoration: BoxDecoration(
                          color: const Color(0xffF4F4F4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            // 시간 선택 피커
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 40,
                                scrollController: FixedExtentScrollController(
                                    initialItem: selectedHour),
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedHour = index;
                                  });
                                },
                                children: List.generate(24, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            // 분 선택 피커
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 40,
                                scrollController: FixedExtentScrollController(
                                    initialItem: selectedMinute),
                                onSelectedItemChanged: (int index) {
                                  setState(() {
                                    selectedMinute = index;
                                  });
                                },
                                children: List.generate(60, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40), // 버튼과 간격 주기

                      // 완료 버튼
                      SizedBox(
                        width: 332,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff424656),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final formattedTime =
                                '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';

                            if (isStart) {
                              // 종료 시간이 이미 설정되어 있다면 비교!
                              final end = timeController.endTime.value;
                              if (end != '없음') {
                                final endHour =
                                    int.parse(end.split(':')[0].trim());
                                final endMinute =
                                    int.parse(end.split(':')[1].trim());

                                final selectedTotalMinutes =
                                    selectedHour * 60 + selectedMinute;
                                final endTotalMinutes =
                                    endHour * 60 + endMinute;

                                if (selectedTotalMinutes >= endTotalMinutes) {
                                  Get.snackbar(
                                    "시간 설정 오류",
                                    "시작 시간은 종료 시간보다 빨라야 합니다.",
                                    backgroundColor:
                                        const Color.fromARGB(255, 88, 88, 88),
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 2),
                                  );
                                  return; // 저장 안 함
                                }
                              }

                              // 정상 저장
                              timeController.startTime.value = formattedTime;
                              timeController.startTimeTextController.text =
                                  formattedTime;
                              print(
                                  "✅ 시작 시간 설정됨: ${timeController.startTime.value}");
                              Navigator.pop(context);
                            } else {
                              // 시작 시간과 비교
                              final start = timeController.startTime.value;
                              final startHour =
                                  int.parse(start.split(':')[0].trim());
                              final startMinute =
                                  int.parse(start.split(':')[1].trim());

                              final selectedTotalMinutes =
                                  selectedHour * 60 + selectedMinute;
                              final startTotalMinutes =
                                  startHour * 60 + startMinute;

                              if (selectedTotalMinutes <= startTotalMinutes) {
                                Get.snackbar(
                                  "시간 설정 오류",
                                  "종료 시간은 시작 시간보다 빠를 수 없습니다.",
                                  backgroundColor:
                                      const Color.fromARGB(255, 88, 88, 88),
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 2),
                                );
                                return; // 저장 안 함
                              }

                              timeController.endTime.value = formattedTime;
                              timeController.endTimeTextController.text =
                                  formattedTime;
                              print(
                                  "✅ 종료 시간 설정됨: ${timeController.endTime.value}");
                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                            child: Text(
                              "완료",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
