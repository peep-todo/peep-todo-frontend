import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/taro_controller.dart';

class TaroCardSelect extends GetView<TaroController> {
  final int number;
  const TaroCardSelect({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final TaroController controller = Get.find<TaroController>();

    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.selectCardDelete(1);
        },
        child: Container(
          width: 92,
          height: 156,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color.fromARGB(255, 91, 91, 91)),
          ),
          child: Transform.rotate(
            angle: controller.selectedCards[number + 1] == true ? pi : 0,
            child: Image.asset(
              "assets/images/taro/taroCard/${controller.selectedCards[number]}.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
