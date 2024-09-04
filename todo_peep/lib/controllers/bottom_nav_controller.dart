import 'package:get/get.dart';

enum PageName { calendar, detail, team, taro, myPage }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;

  void changeBottomNav(int value) {
    var page = PageName.values[value];

    switch (page) {
      case PageName.calendar:
      case PageName.detail:
      case PageName.myPage:
      case PageName.taro:
      case PageName.team:
        //각각의 네비영역을 클릭시 해당하는 페이지로 이동하기위해
        pageIndex(value);
        break;
    }
  }
}
