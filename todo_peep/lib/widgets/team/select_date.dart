import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectDate extends StatefulWidget {
  final String startDate;
  final String endDate;
  //넘겨줄 콜백 함수
  final void Function(DateTime? start, DateTime? end)? onDateRangeSelected;

  const SelectDate(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.onDateRangeSelected});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  String _displayDate = '';
  DateRangePickerController dateRangePickerController =
      DateRangePickerController();

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    _updateDisplayDate(DateTime.now());
  }

  //헤더의 변경을 위해
  void _updateDisplayDate(DateTime date) {
    setState(() {
      _displayDate = _formatDate(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 50,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xffE5E8EB),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 21),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 왼쪽 화살표 버튼
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_left_rounded,
                            size: 30, color: Color(0xff0A1811)), // 커스텀 화살표
                        onPressed: () {
                          // 이전 월로 이동
                          dateRangePickerController.backward!();
                        },
                      ),
                      // 중앙에 있는 현재 월과 연도
                      Text(
                        _displayDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0A1811),
                        ),
                      ),
                      // 오른쪽 화살표 버튼
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_right_rounded,
                            size: 30, color: Color(0xff0A1811)), // 커스텀 화살표
                        onPressed: () {
                          // 다음 월로 이동
                          dateRangePickerController.forward!();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDayName('일'),
                        _buildDayName('월'),
                        _buildDayName('화'),
                        _buildDayName('수'),
                        _buildDayName('목'),
                        _buildDayName('금'),
                        _buildDayName('토'),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: SfDateRangePicker(
                      controller: dateRangePickerController,
                      showNavigationArrow: false,
                      headerStyle: const DateRangePickerHeaderStyle(
                        backgroundColor: Colors.white,
                        textStyle:
                            TextStyle(color: Colors.transparent), // 기본 헤더 숨기기
                      ),
                      minDate: DateTime(2025),
                      maxDate: DateTime(2030),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        if (args.value is PickerDateRange) {
                          final PickerDateRange range = args.value;
                          final DateTime? start = range.startDate;
                          final DateTime? end = range.endDate;

                          if (widget.onDateRangeSelected != null) {
                            widget.onDateRangeSelected!(start, end);
                          }
                          if (start != null && end != null) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      selectionMode: DateRangePickerSelectionMode.range,
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                        textStyle:
                            TextStyle(fontSize: 14, color: Color(0xff0A1811)),
                        todayTextStyle:
                            TextStyle(fontSize: 14, color: Colors.red),
                        todayCellDecoration:
                            BoxDecoration(shape: BoxShape.circle),
                        leadingDatesTextStyle: TextStyle(
                          color: Color(0xffcfcfcf),
                        ),
                        trailingDatesTextStyle: TextStyle(
                          color: Color(0xffcfcfcf),
                        ),
                      ),
                      startRangeSelectionColor: const Color(0xff424656),
                      endRangeSelectionColor: const Color(0xff424656),
                      selectionTextStyle: const TextStyle(color: Colors.white),
                      rangeSelectionColor: const Color(0xffD7D8DC),
                      allowViewNavigation: false,
                      backgroundColor: Colors.white,
                      headerHeight: 2,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                        showTrailingAndLeadingDates: true,
                        dayFormat: "",
                        viewHeaderHeight: 1,
                      ),
                      onViewChanged: (DateRangePickerViewChangedArgs args) {
                        final DateTime displayedDate =
                            dateRangePickerController.displayDate ??
                                DateTime.now();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _updateDisplayDate(displayedDate);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

Widget _buildDayName(String dayName) {
  return Center(
    child: Text(
      dayName,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff7B827E)),
    ),
  );
}
