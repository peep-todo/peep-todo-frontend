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
  final Map<int, GlobalKey> dateKeys = {}; // 각 날짜의 GlobalKey 저장

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

    // 날짜별 GlobalKey 초기화
    for (int i = 0; i < 7; i++) {
      dateKeys[i] = GlobalKey();
    }
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

  /// 현재 주의 시작 날짜 구하기 (일요일 기준)
  DateTime get currentWeekStart {
    return today
        .subtract(Duration(days: today.weekday % 7))
        .add(Duration(days: (weekOffset - 1000) * 7));
  }

  /// 주간 날짜 리스트 생성
  List<DateTime> get weekDates {
    return List.generate(
        7, (index) => currentWeekStart.add(Duration(days: index)));
  }

  void updateWeek(int offset) {
    setState(() {
      weekOffset = offset;
    });
  }

  /// 선택된 날짜의 위치를 찾아 반환하는 함수
  Offset? getSelectedDateOffset() {
    for (int i = 0; i < 7; i++) {
      if (weekDates[i] == selectedDate) {
        final RenderBox? renderBox =
            dateKeys[i]!.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          return position;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String month = DateFormat.MMMM('ko').format(currentWeekStart);
    String fullDate = DateFormat('yyyy년 MM월 dd일', 'ko').format(selectedDate);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFf4f4f4), Color.fromRGBO(255, 255, 255, 1)],
              ),
            ),
          ),
          Padding(
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
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    // 선택된 날짜를 기준으로 네이비 박스 추가
                    Positioned(
                      top: getSelectedDateOffset()?.dy ?? 0 - 50,
                      left: getSelectedDateOffset()?.dx ?? 0 - 5,
                      child: Container(
                        width: 50,
                        height: 100, // 요일까지 덮도록 설정
                        decoration: BoxDecoration(
                          color: const Color(0xFF424656),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
