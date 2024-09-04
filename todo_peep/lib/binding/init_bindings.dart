import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:todo_peep/controllers/bottom_nav_controller.dart';

class InitBindings extends Bindings {
  // 애플리케이션의 초기화 과정에서 dependencies() 메서드를
  // 통해 필요한 컨트롤러, 서비스 등을 미리 등록해둡니다.

  //permanent: true 옵션은 이 인스턴스를 애플리케이션이 종료될 때까지
  //메모리에서 제거하지 않도록 합니다. 즉, 이 컨트롤러는 앱이 살아있는 동안 항상 유지됩니다.

  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
  }
}
