import 'package:flutter/material.dart';
import 'package:todo_peep/widgets/detail/detail_overlay_menu.dart';

enum Type { team, personal }

class DetailCheckboxComponenet extends StatefulWidget {
  final Map<String, dynamic> taskData;

  const DetailCheckboxComponenet({required this.taskData, super.key});

  @override
  State<DetailCheckboxComponenet> createState() =>
      _DetailCheckboxComponenetState();
}

class _DetailCheckboxComponenetState extends State<DetailCheckboxComponenet> {
  late bool isChecked;

  //overlayMenu를 위한 변수
  final GlobalKey _iconKey = GlobalKey();
  late OverlayMenu _overlayMenu;

  @override
  void initState() {
    super.initState();
    isChecked = widget.taskData['isChecked'] as bool;
    _overlayMenu = OverlayMenu(context);
  }

  //checkbox 클릭시 토글
  void isClicked() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  //overlayMenu 토글
  void _toggleMenu() {
    RenderBox renderBox =
        _iconKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    if (!_overlayMenu.isVisible()) {
      _overlayMenu.show(position: position);
    } else {
      _overlayMenu.hide();
    }
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
                .withOpacity(0.1)
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 16),
            GestureDetector(
              onTap: isClicked,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, // 체크박스 모양 (사각형)
                  borderRadius: BorderRadius.circular(5), // 모서리 둥글기
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
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                widget.taskData['name'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(width: 9),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.5),
              child: Text(
                "${widget.taskData['startTime']} - ${widget.taskData['endTime']}",
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xff808080),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: _toggleMenu,
                child: Icon(
                  key: _iconKey,
                  Icons.more_vert,
                  color: const Color(0xffD1D1D6),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
