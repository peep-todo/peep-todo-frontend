import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:todo_peep/widgets/checkbox_componenet.dart';
import 'package:todo_peep/widgets/detail/add_choice_detaillist.dart';
import 'package:todo_peep/controllers/detail_task_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_peep/widgets/detail/detail_checkbox_componenet.dart';

class DetailList extends StatefulWidget {
  const DetailList({super.key});

  @override
  _DetailListState createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> with WidgetsBindingObserver {
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  int weekOffset = 1000;
  late PageController _pageController;

  // hasSchedule을 사용하지 않고, 이미지가 항상 보이도록 변경
  double dateGap = 8.0; // 날짜 간의 간격을 설정할 수 있는 변수 추가
  double boxWidth = 40.0; // 날짜 박스의 너비를 설정할 수 있는 변수 추가

  List<Map<String, dynamic>> taskData = [
    {
      'category': '알바',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'FFB1AC',
      'isChecked': true,
    },
    {
      'category': '알바',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'FFB1AC',
      'isChecked': false,
    },
    {
      'category': '약속',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'CDE5D5',
      'isChecked': true,
    },
    {
      'category': '약속',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'CDE5D5',
      'isChecked': false,
    },
    {
      'category': '해야할 일',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'BFC4D7',
      'isChecked': false,
    },
    {
      'category': '해야할 일',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'BFC4D7',
      'isChecked': true,
    },
    {
      'category': '일',
      'name': '근로',
      'type': 'detail',
      'startDate': '',
      'endDate': '',
      'startTime': '10:10',
      'endTime': '17:00',
      'color': 'BFC4D7',
      'isChecked': true,
    },
  ];

  late String category = "";
  late String name = "";
  late String time = "";
  late bool categoryChanged = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _pageController = PageController(initialPage: weekOffset);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(weekOffset);
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_pageController.hasClients) {
            _pageController.jumpToPage(weekOffset);
          }
        });
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetToToday();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resetToToday();
  }

  void _resetToToday() {
    setState(() {
      today = DateTime.now();
      selectedDate = today;
      weekOffset = 1000;
    });
    if (_pageController.hasClients) {
      _pageController.jumpToPage(weekOffset);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  DateTime get currentWeekStart {
    return today
        .subtract(Duration(days: today.weekday % 7))
        .add(Duration(days: (weekOffset - 1000) * 7));
  }

  List<DateTime> get weekDates {
    return List.generate(
        7, (index) => currentWeekStart.add(Duration(days: index)));
  }

  void updateWeek(int offset) {
    setState(() {
      weekOffset = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    String month = weekOffset == 1000
        ? DateFormat.MMMM('ko').format(selectedDate)
        : DateFormat.MMMM('ko').format(currentWeekStart);

    String fullDate = DateFormat('yyyy년 MM월 dd일', 'ko').format(selectedDate);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFf4f4f4), Color.fromRGBO(255, 255, 255, 1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(29, 70, 29, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 날짜 정보
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        month,
                        style: const TextStyle(
                          fontSize: 32,
                          color: Color(0xff595959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        fullDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff929292),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 37),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(20),
                              ),
                              child: Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width - 20,
                                height: 97 +
                                    ((MediaQuery.of(context).size.width - 94) /
                                        3),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: AddChoiceDetaillist(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Colors.white,
                      minimumSize: const Size(63, 33),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: const Text(
                      "+ Add",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 요일 + 날짜 선택
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 요일 (고정된 부분)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['일', '월', '화', '수', '목', '금', '토']
                        .map((day) => SizedBox(
                              width: 50,
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xFF808080),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 2),
                  // 날짜 (스크롤 가능)
                  SizedBox(
                    height: 40,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: updateWeek,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(7, (dayIndex) {
                            DateTime date = weekDates[dayIndex];
                            bool isSelected = date.year == selectedDate.year &&
                                date.month == selectedDate.month &&
                                date.day == selectedDate.day;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                              child: SizedBox(
                                width: 50,
                                child: Center(
                                  child: Container(
                                    width: isSelected ? 40 : 50,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF424656)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF808080),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // 일정이 없을 때 보여줄 이미지
              // Expanded(
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset(
              //           'assets/images/detaillist/detailMain.png',
              //           height: 133,
              //           width: 165,
              //         ),
              //         const SizedBox(height: 10), // 이미지와 텍스트 사이의 간격
              //         const Text(
              //           '일정을 추가해주세요',
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400,
              //             color: Color(0xFFCFCFCF),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              const SizedBox(height: 29),
              // 일정 목록 추가
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero, // 여백 제거
                  itemBuilder: (context, index) {
                    if (category != taskData[index]['category']) {
                      category = taskData[index]['category'];
                      categoryChanged = true;
                    } else {
                      categoryChanged = false;
                    }

                    if (categoryChanged &&
                        category == taskData[0]['category']) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: taskData[index]['color'] != null
                                    ? Color(int.parse(
                                        '0xff${taskData[index]['color']}'))
                                    : Colors.black,
                              ),
                              const SizedBox(width: 10), // 글머리 기호와 텍스트 사이의 간격
                              Text(
                                taskData[index]['category'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: SvgPicture.asset(
                                  "assets/images/common/pin.svg",
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9), // 카테고리 하단의 간격
                          DetailCheckboxComponenet(taskData: taskData[index]),
                        ],
                      );
                    } else if (categoryChanged &&
                        category != taskData[0]['category']) {
                      return Column(
                        children: [
                          const SizedBox(height: 27), // 카테고리 간 간격
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 15,
                                color: taskData[index]['color'] != null
                                    ? Color(int.parse(
                                        '0xff${taskData[index]['color']}'))
                                    : Colors.black,
                              ),
                              const SizedBox(width: 10), // 글머리 기호와 텍스트 사이의 간격
                              Text(
                                taskData[index]['category'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9), // 카테고리 하단의 간격
                          DetailCheckboxComponenet(taskData: taskData[index]),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 9),
                          DetailCheckboxComponenet(taskData: taskData[index]),
                        ],
                      );
                    }
                  },
                  itemCount: taskData.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
