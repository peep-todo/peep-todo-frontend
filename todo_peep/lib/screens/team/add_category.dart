import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/team_task_controller.dart';

class AddCategory extends GetView<TeamTaskController> {
  AddCategory({super.key});

  final List<String> colorList = [
    "FFB1AC",
    "FFD4AC",
    "FFF2AC",
    "DAFFAC",
    "B9E2EE",
    "ACC3FF",
    "CBACFF",
    "FFACCF"
  ];

  final TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<TeamTaskController>()) {
      Get.delete<TeamTaskController>();
    }
    Get.put(TeamTaskController());
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
              "카테고리 생성",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  "완료",
                  style: controller.categoryAllFinished == true.obs
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
          body: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Text(
                        "카테고리 색상",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff808080),
                        ),
                      ),
                      SizedBox(width: 7),
                      Text(
                        "원하는 색상으로 꾸며보세요!",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                          color: Color(0xffbcbcbc),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: colorList.map((color) {
                      return GestureDetector(
                        onTap: () {
                          controller.onCategoryColorChanged(color);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(int.parse("0xff$color")),
                            border: controller.categoryColor.toString() == color
                                ? Border.all(color: const Color(0xff424656))
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "카테고리",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(height: 3),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: "카테고리를 입력하세요",
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
                    onChanged: controller.onCategoryNameChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
