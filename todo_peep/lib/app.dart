import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todo_peep/controllers/bottom_nav_controller.dart';
import 'package:todo_peep/screens/taro/select_taro.dart';
import 'package:todo_peep/screens/taro/taro_loading.dart';
import 'package:todo_peep/screens/taro/taro_result.dart';
import 'package:todo_peep/screens/team/team.dart';

//StatelessWidget대신 GetView<BottomNavController> 를 상속받아 BottomNavController의
//변수 및 메소드에 접근가능하도록
class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            //일단은 텍스트 여기서 너희가 만든 페이지를 자식으로 변경 ㄱㄱ
            const Text("data"),
            const Text("data"),
            Team(),
            const SelectTaro(),
            const Text("data"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xffFFFFFF),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          selectedItemColor: Colors.black,
          unselectedFontSize: 13,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: controller.pageIndex.value,
          onTap: controller.changeBottomNav,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/Calendar.svg'),
              activeIcon: SvgPicture.asset(
                'assets/images/Calendar.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '캘린더',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/Detail.svg'),
              activeIcon: SvgPicture.asset(
                'assets/images/Detail.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '세부 일정',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/Team.svg'),
              activeIcon: SvgPicture.asset(
                'assets/images/Team.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '팀 프로젝트',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/Taro 1.svg'),
              activeIcon: SvgPicture.asset(
                'assets/images/Taro 1.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '타로',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/Mypage.svg'),
              activeIcon: SvgPicture.asset(
                'assets/images/Mypage.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '내 정보',
            ),
          ],
        ),
      ),
    );
  }
}
