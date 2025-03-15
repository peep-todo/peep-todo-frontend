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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // _pageController 초기화
    _pageController = PageController(initialPage: weekOffset);

    /// 페이지 처음 실행될 때 당일 날짜로 선택
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // PageView가 실제로 렌더링된 후에만 _pageController가 연결되도록 확인
      if (_pageController.hasClients) {
        _pageController.jumpToPage(weekOffset); // 페이지 이동
      } else {
        // 만약 PageView가 아직 렌더링되지 않았다면 다시 시도
        Future.delayed(Duration(milliseconds: 100), () {
          if (_pageController.hasClients) {
            _pageController.jumpToPage(weekOffset); // 페이지 이동
          }
        });
      }
    });
  }

  /// 앱이 다시 활성화될 때(다른 페이지 갔다가 다시 돌아올 때)도 당일 날짜로 초기화
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetToToday();
    }
  }

  /// 페이지로 돌아오면 당일 날짜로 선택되도록 설정
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resetToToday();
  }

  /// 오늘 날짜로 리셋하는 함수
  void _resetToToday() {
    setState(() {
      today = DateTime.now();
      selectedDate = today;
      weekOffset = 1000; // 오늘 날짜가 포함된 주로 설정
    });
    if (_pageController.hasClients) {
      _pageController.jumpToPage(weekOffset); // 강제 이동
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  // 현재 주의 시작 날짜 구하기 (일요일 기준)
  DateTime get currentWeekStart {
    return today
        .subtract(Duration(days: today.weekday % 7))
        .add(Duration(days: (weekOffset - 1000) * 7));
  }

  // 주간 날짜 리스트 생성
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
                      Get.toNamed("/team/add");
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (dayIndex) {
                      return Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          ['일', '월', '화', '수', '목', '금', '토'][dayIndex],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: updateWeek,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: Container(
                                width: 40,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF424656)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${date.day}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Color(0xFF808080),
                                      ),
                                    ),
                                  ],
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
            ],
          ),
        ),
      ),
    );
  }
}
