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
            leading: Padding(
              padding: const EdgeInsets.only(left: 24), // 뒤로가기 버튼 패딩 조절
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  await Get.toNamed("/team/detail/viewAll");
                },
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
                  const SizedBox(height: 16),
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
                                  : const Color(0xffD1D1D6), // 체크 여부에 따른 테두리 색상
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
                        "카테고리 상단 고정",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff525252),
                        ),
                      ),
                    ],
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
