import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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

  bool hasSchedule = false; // 일정이 추가되지 않았는지 여부

  double dateGap = 8.0; // 날짜 간의 간격을 설정할 수 있는 변수 추가
  double boxWidth = 40.0; // 날짜 박스의 너비를 설정할 수 있는 변수 추가

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
    String month = DateFormat.MMMM('ko').format(currentWeekStart);
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
              /// 상단 날짜 정보
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
                      setState(() {
                        hasSchedule = true;
                      });
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

              /// 요일 + 날짜 선택 (고정된 요일 + 스크롤되는 날짜)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 요일 (고정된 부분)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['일', '월', '화', '수', '목', '금', '토']
                        .map((day) => SizedBox(
                              width: 50, // 날짜와 동일한 크기로 통일
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

                  const SizedBox(height: 6), // 요일과 날짜 간격 조정

                  // 날짜 (스크롤 가능)
                  SizedBox(
                    height: 50,
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
                                width: 50, // 요일과 동일한 너비 유지
                                child: Center(
                                  // 내부 컨테이너를 중앙 정렬
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
              if (!hasSchedule)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/detaillist/detailMain.png',
                          height: 133,
                          width: 165,
                        ),
                        const SizedBox(height: 10), // 이미지와 텍스트 사이의 간격
                        const Text(
                          '일정을 추가해주세요',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFCFCFCF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
