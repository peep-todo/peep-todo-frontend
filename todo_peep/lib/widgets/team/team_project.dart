import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get/get.dart';

class TeamProject extends StatelessWidget {
  final Map<String, dynamic> teamData;
  TeamProject({super.key, required this.teamData});

  double get complete => (teamData['complete'] as double?) ?? 0.0;
  double get totalValue => (teamData['totalValue'] as double?) ?? 1.0;

  final colorList = <Color>[
    Colors.greenAccent,
    const Color(0xfff4f4f4),
  ];
  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Complete": complete,
      "Incomplete": totalValue - complete,
    };
    return GestureDetector(
      onTap: () {
        Get.toNamed("/team/detail", arguments: teamData);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 22),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${teamData['name']}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${teamData['teamName']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff808080),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    "Member",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 0),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 126, 119, 98),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-20, 0),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/team/team_calendar.svg",
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "${teamData['endDate']}",
                        style: const TextStyle(
                          color: Color(0xffcfcfcf),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 19),
                    SizedBox(
                      width: 95,
                      height: 95,
                      child: PieChart(
                        animationDuration: const Duration(seconds: 5),
                        dataMap: dataMap,
                        chartType: ChartType.ring,
                        baseChartColor: const Color(0xfff4f4f4),
                        colorList: colorList,
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValues: false,
                        ),
                        totalValue: totalValue,
                        legendOptions: const LegendOptions(
                          showLegends: false,
                        ),
                        ringStrokeWidth: 10,
                        initialAngleInDegree: 270,
                        centerWidget: Center(
                          child: Text(
                            "${(dataMap['Complete']! / 10 * 100).toStringAsFixed(0)}%",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.greenAccent),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          "assets/images/team/team_check.svg",
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "12 Tasks",
                          style: TextStyle(
                            color: Color(0xffcfcfcf),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
