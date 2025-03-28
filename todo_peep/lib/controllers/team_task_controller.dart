import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamTaskController extends GetxController {
  RxString category = "".obs;
  RxBool categoryPin = false.obs;
  RxString schedule = "".obs;
  RxString assignedTo = "".obs;
  RxString start = ''.obs;
  RxString end = ''.obs;
  RxBool allFinish = false.obs;

  RxString categoryName = "".obs;
  RxString categoryColor = "".obs;
  RxBool categoryAllFinished = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 초기화 작업을 여기서 수행합니다.
    initializeProject();
  }

  void initializeProject() {
    category = "".obs;
    categoryPin = false.obs;
    schedule = "".obs;
    assignedTo = "".obs;
    start = "".obs;
    end = "".obs;
    allFinish = false.obs;
    categoryName = "".obs;
    categoryColor = "".obs;
    categoryAllFinished = false.obs;
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

  void onAssignedToChanged(String value) {
    assignedTo(value);
    allFinished();
  }

  void allFinished() {
    print("$category ㅎ포 $schedule $assignedTo $start $end");
    if (category != ''.obs &&
        schedule != ''.obs &&
        assignedTo != ''.obs &&
        start != ''.obs &&
        end != ''.obs) {
      allFinish(true);
    } else {
      allFinish(false);
    }
  }

  void onCategoryNameChanged(String value) {
    categoryName(value);
    categoryallFinished();
  }

  void onCategoryColorChanged(String value) {
    categoryColor(value);
    categoryallFinished();
  }

  void onCategoryPinToggle() {
    categoryPin.value = !categoryPin.value;
  }

  void categoryallFinished() {
    if (categoryName != ''.obs && categoryColor != ''.obs) {
      categoryAllFinished(true);
    } else {
      categoryAllFinished(false);
    }
  }
}
