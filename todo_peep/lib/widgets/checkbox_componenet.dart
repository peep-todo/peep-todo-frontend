import 'package:flutter/material.dart';

enum Type { team, personal }

class CheckboxComponenet extends StatefulWidget {
  final Map<String, dynamic> taskData;

  const CheckboxComponenet({required this.taskData, super.key});

  @override
  State<CheckboxComponenet> createState() => _CheckboxComponenetState();
}

class _CheckboxComponenetState extends State<CheckboxComponenet> {
  late bool isChecked;
  @override
  void initState() {
    super.initState();
    isChecked = widget.taskData['isChecked'] as bool;
  }

  void isClicked() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isChecked
            ? Color(int.parse('0xff${widget.taskData['color']}'))
                .withOpacity(0.2)
            : Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          GestureDetector(
            onTap: isClicked,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // 체크박스 모양 (사각형)
                borderRadius: BorderRadius.circular(4), // 모서리 둥글기
                border: Border.all(
                  color: isChecked
                      ? Color(int.parse('0xff${widget.taskData['color']}'))
                      : const Color(0xffD1D1D6), // 체크 여부에 따른 테두리 색상
                  width: 1,
                ),
                color: isChecked
                    ? Color(int.parse('0xff${widget.taskData['color']}'))
                    : Colors.white, // 체크 여부에 따른 배경색
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 10),
          Text(widget.taskData['name']),
          const SizedBox(width: 9),
          Text(
            widget.taskData['type'] != Type.team
                ? "${widget.taskData['startDate']} - ${widget.taskData['endDate']}"
                : "${widget.taskData['startTime']} - ${widget.taskData['endTime']}",
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xff808080),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  isScrollControlled: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: screenWidth - 20,
                      height: screenHeight * 0.45, // 원하는 높이로 설정
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(child: Text("디자인이 안나왔다고 합니다ㅠㅜㅠㅜ")),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.more_vert,
                color: Color(0xffD1D1D6),
              ),
            ),
          )
        ],
      ),
    );
  }
}
