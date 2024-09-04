import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_peep/app.dart';
import 'package:todo_peep/binding/init_bindings.dart';
import 'package:todo_peep/screens/team/project_create.dart';
import 'package:todo_peep/screens/team/team_project_add.dart';

void main() {
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
          elevation: 0,
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
        GetPage(name: "/team/add", page: () => TeamProjectAdd()),
        GetPage(name: "/team/create", page: () => const ProjectCreate())
      ],
      initialRoute: "/",
    );
  }
}
