import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';

class TaroCardSelect extends GetView<TaroController> {
  final int number;
  const TaroCardSelect({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final TaroController controller = Get.find<TaroController>();
    late RxBool animate = false.obs;
    late String text = "";
    if (number == 0) {
      animate = controller.loveFortuneAnimation;
      text = "애정운";
    } else if (number == 2) {
      animate = controller.wealthFortuneAnimation;
      text = "재물운";
    } else {
      animate = controller.studyFortuneAnimation;
      text = "학업&취업운";
    }
    return Obx(
      () => SizedBox(
        width: 92,
        height: 156,
        child: animate == false.obs
            ? DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(5),
                dashPattern: const [6, 3],
                color: const Color(0xffbcbcbc),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xff929292),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            : Transform.rotate(
                angle: controller.selectedCards[number + 1] == true ? pi : 0,
                child: Image.asset(
                  "assets/images/taro/taroCard/${controller.selectedCards[number]}.png",
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }
}
