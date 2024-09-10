import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamTaskController extends GetxController {
  RxString category = "".obs;
  RxString schedule = "".obs;
  RxString description = "".obs;
  RxString start = ''.obs;
  RxString end = ''.obs;
  RxBool allFinish = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 초기화 작업을 여기서 수행합니다.
    initializeProject();
  }

  void initializeProject() {
    category = "".obs;
    schedule = "".obs;
    description = "".obs;
    start = "".obs;
    end = "".obs;
    allFinish = false.obs;
  }

  //시작 날짜와 종료날짜 입력시 값 변환
  void handleDateRangeSelected(DateTime? startDate, DateTime? endDate) {
    if (startDate != null && endDate != null) {
      start(DateFormat('yyyy-MM-dd').format(startDate));
      end(DateFormat('yyyy-MM-dd').format(endDate));
      allFinished();
    } else if (startDate != null && endDate == null) {
      start(DateFormat('yyyy-MM-dd').format(startDate));
      end(DateFormat('yyyy-MM-dd').format(startDate));
      allFinished();
    }
  }

  void onCategoryChanged(String value) {
    category(value);
    allFinished();
  }

  void onScheduleChanged(String value) {
    schedule(value);
    allFinished();
  }

  void onDescriptionChanged(String value) {
    description(value);
    allFinished();
  }

  void allFinished() {
    if (category != ''.obs &&
        schedule != ''.obs &&
        description != ''.obs &&
        start != ''.obs &&
        end != ''.obs) {
      allFinish(true);
    } else {
      allFinish(false);
    }
  }
}
