import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'add_day.dart';

class MainCalendar extends StatelessWidget {
  const MainCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf4f4f4),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '${DateTime.now().month}월',
                  style: const TextStyle(
                    color: Color(0xFF595959),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 21),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.check_box, color: Colors.orange, size: 22),
                    SizedBox(width: 5),
                    Text(
                      "D-DAY",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                child: Row(
                  children: [
                    _buildDdayBox("D+27", "컴활필기시험"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddDdayScreen()),
                          );
                        },
                        child: _buildAddDdayBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDdayBox(String days, String title) {
    return Container(
      width: 184,
      height: 82,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: DottedBorder(
              color: const Color(0xFFC6C8C8),
              borderType: BorderType.Circle,
              dashPattern: const [3, 2],
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/calendar/image-add.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                    color: const Color(0xFFC6C8C8),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFC6C8C8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddDdayBox() {
    return SizedBox(
      width: 184,
      height: 82,
      child: DottedBorder(
        color: const Color(0xFFC6C8C8),
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [3, 2],
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Color(0xFFC6C8C8), size: 16),
              SizedBox(width: 4),
              Text(
                "디데이를 추가해보세요",
                style: TextStyle(color: Color(0xFFC6C8C8), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
