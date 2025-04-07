import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart'; // CupertinoTimerPicker 추가
import 'package:flutter/material.dart';
import 'package:todo_peep/widgets/detail/select_time.dart';

class TimeController extends GetxController {
  var startTime = ''.obs;
  var endTime = ''.obs;
}

void showCustomTimePicker(BuildContext context, {required bool isStart}) {
  final timeController = Get.find<TimeController>(); // TimeController 가져오기

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
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const Text(":", style: TextStyle(fontSize: 20)),
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
                SizedBox(
                  width: double.infinity,
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
                        timeController.startTime.value =
                            formattedTime; // 수정된 부분
                      } else {
                        timeController.endTime.value = formattedTime; // 수정된 부분
                      }

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "완료",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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
