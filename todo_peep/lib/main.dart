import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/app.dart';
import 'package:todo_peep/binding/init_bindings.dart';
import 'package:todo_peep/screens/taro/taro_loading.dart';
import 'package:todo_peep/screens/taro/taro_result.dart';
import 'package:todo_peep/screens/team/add_category.dart';
import 'package:todo_peep/screens/team/add_schedule.dart';
import 'package:todo_peep/screens/team/project_create.dart';
import 'package:todo_peep/screens/team/team.dart';
import 'package:todo_peep/screens/team/team_detail.dart';
import 'package:todo_peep/screens/team/team_detail_veiwall.dart';
import 'package:todo_peep/screens/team/team_project_add.dart';
import 'package:todo_peep/screens/detaillist/detaillist.dart';
import 'package:intl/date_symbol_data_local.dart'; // 추가
import 'package:todo_peep/screens/detaillist/detail_category.dart';
import 'package:todo_peep/screens/detaillist/detail_schedule.dart';
import 'package:todo_peep/controllers/detail_task_controller.dart';
import 'package:todo_peep/widgets/detail/select_time.dart';

void main() async {
  // 로케일 데이터 초기화
  await initializeDateFormatting('ko_KR', null);

  // ✅ 컨트롤러 인스턴스 등록
  Get.put(DetailTaskController());
  Get.put(TimeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'SFPro',
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 0.0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      //앱 실행과 동시에 인스턴스 생성?
      initialBinding: InitBindings(),
      getPages: [
        GetPage(name: "/", page: () => const App()),
        GetPage(name: "/team", page: () => Team()),
        GetPage(name: "/team/add", page: () => TeamProjectAdd()),
        GetPage(name: "/team/create", page: () => const ProjectCreate()),
        GetPage(name: "/team/detail", page: () => TeamDetail()),
        GetPage(name: "/team/detail/viewAll", page: () => TeamDetailViewall()),
        GetPage(name: "/team/add/schedule", page: () => AddSchedule()),
        GetPage(name: "/team/add/category", page: () => AddCategory()),
        GetPage(name: "/taro/result", page: () => TaroResult()),
        GetPage(name: "/taro/loading", page: () => const TaroLoading()),
        GetPage(name: "/detaillist", page: () => const DetailList()),
        GetPage(
            name: "/detaillist/detail/category",
            page: () => AddCategoryDetaillist()),
        GetPage(
            name: "/detaillist/detail/schedule",
            page: () => AddScheduleDetaillist()),
        // GetPage(
        //     name: "/splash",
        //     page: () => const SplashScreen()), // 스플래시 스크린 경로 추가
      ],
      initialRoute: "/",
    );
  }
}
