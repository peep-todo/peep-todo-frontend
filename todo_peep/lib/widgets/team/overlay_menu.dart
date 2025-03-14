// overlay_menu.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OverlayMenu {
  final BuildContext context;
  OverlayEntry? _overlayEntry;

  OverlayMenu(this.context);

  // 메뉴를 보여주는 메서드
  void show({required Offset position}) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (_overlayEntry != null) return; // 이미 표시 중이면 실행 X

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          // 배경을 클릭하면 메뉴를 숨김
          hide();
        },
        child: Material(
          color: Colors.transparent, // 투명 배경
          child: Stack(
            children: [
              // 메뉴 외부 클릭 시 메뉴를 숨길 수 있도록 배경을 감싸는 GestureDetector
              Positioned.fill(
                child: Container(),
              ),
              // 실제 메뉴 위치
              Positioned(
                top: position.dy + 35,
                left: screenWidth * 0.65 - 29, // 아이콘 바로 아래 위치
                child: Material(
                  child: _buildMenu(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // 메뉴를 숨기는 메서드
  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // 메뉴가 보이는지 확인하는 메서드
  bool isVisible() {
    return _overlayEntry != null;
  }

  Widget _buildMenu() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.35,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xff434961).withOpacity(0.1), // 그림자 색상과 투명도
              offset: const Offset(0, 5), // 그림자의 위치
              blurRadius: 2, // 흐림 정도
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: const Color.fromARGB(26, 67, 73, 97),
            width: 1,
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _menuItem("수정 하기", "assets/images/common/Edit.svg"),
          _menuItem("삭제 하기", "assets/images/common/Delete.svg"),
        ],
      ),
    );
  }

  Widget _menuItem(String text, String icon) {
    return InkWell(
      onTap: () {
        print('$text 클릭됨');
        hide();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              // width: 15,
              // height: 15,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff424656),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
