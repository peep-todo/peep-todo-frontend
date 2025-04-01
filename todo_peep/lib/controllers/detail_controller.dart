import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailController extends GetxController {
  //나의 프로젝트 창에서 모두보기1, 진행중2, 완료된3을 나누어 보기 위하여
  RxInt select = 1.obs;

  //프로젝트생성에서 값의 여부에따라 하단버튼의 색변경
  RxString teamName = ''.obs;
  RxString projectName = ''.obs;
  RxString description = ''.obs;
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
    teamName = ''.obs;
    projectName = ''.obs;
    description = ''.obs;
    start = ''.obs;
    end = ''.obs;

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

  //팀이름 입력시 값 변환
  void onTeamNameChanged(String value) {
    teamName(value);
    allFinished();
  }

  void onProjectNameChanged(String value) {
    projectName(value);
    allFinished();
  }

  void onDescriptionChanged(String value) {
    description(value);
    allFinished();
  }

  void allFinished() {
    if (teamName != ''.obs &&
        projectName != ''.obs &&
        description != ''.obs &&
        start != ''.obs &&
        end != ''.obs) {
      allFinish(true);
    } else {
      allFinish(false);
    }
  }
}
