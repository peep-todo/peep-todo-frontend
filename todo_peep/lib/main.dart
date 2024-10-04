import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/app.dart';
import 'package:todo_peep/binding/init_bindings.dart';
import 'package:todo_peep/screens/team/add_category.dart';
import 'package:todo_peep/screens/team/add_schedule.dart';
import 'package:todo_peep/screens/team/project_create.dart';
import 'package:todo_peep/screens/team/team.dart';
import 'package:todo_peep/screens/team/team_detail.dart';
import 'package:todo_peep/screens/team/team_detail_veiwall.dart';
import 'package:todo_peep/screens/team/team_project_add.dart';
import 'package:todo_peep/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SFPro',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      initialBinding: InitBindings(),
      getPages: [
        GetPage(name: "/", page: () => const App()),
        GetPage(
            name: "/splash",
            page: () => const SplashScreen()), // 스플래시 스크린 경로 추가
        GetPage(name: "/team", page: () => Team()),
        GetPage(name: "/team/add", page: () => TeamProjectAdd()),
        GetPage(name: "/team/create", page: () => const ProjectCreate()),
        GetPage(name: "/team/detail", page: () => const TeamDetail()),
        GetPage(name: "/team/detail/viewAll", page: () => TeamDetailViewall()),
        GetPage(name: "/team/add/schedule", page: () => AddSchedule()),
        GetPage(name: "/team/add/category", page: () => AddCategory())
      ],
      initialRoute: "/splash", // 앱 실행 시 스플래시 스크린으로 시작
    );
  }
}
