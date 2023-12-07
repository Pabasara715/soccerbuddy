import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );
  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.redAccent,
        gradient: LinearGradient(colors: [
          Colors.pink.withOpacity(0.4),
          Colors.blueAccent.withOpacity(0.4)
        ]),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: Colors.pink, end: Colors.blueAccent)
                  .lerp(0.1)!
                  .withOpacity(0.2),
              ColorTween(begin: Colors.pink, end: Colors.blueAccent)
                  .lerp(0.2)!
                  .withOpacity(0.2),
            ],
          ),
        ),
        spots: const [
          FlSpot(1, 10),
          FlSpot(2, 30),
          FlSpot(3, 15),
          FlSpot(4, 70),
          FlSpot(5, 34),
          FlSpot(6, 76),
          FlSpot(7, 21),
        ],
      );

  SideTitles rightTitles() => SideTitles(
        getTitlesWidget: rightTitleWidgets,
        showTitles: true,
        interval: 20,
        reservedSize: 40,
      );
  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.pink,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0%';
        break;
      case 20:
        text = '20%';
        break;
      case 40:
        text = '40%';
        break;
      case 60:
        text = '60%';
        break;
      case 80:
        text = '80%';
        break;
      case 100:
        text = '100%';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.pink,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Sun', style: style);
        break;
      case 2:
        text = const Text('Mon', style: style);
        break;
      case 3:
        text = const Text('Tue', style: style);
        break;
      case 4:
        text = const Text('Wed', style: style);
        break;
      case 5:
        text = const Text('Thu', style: style);
        break;
      case 6:
        text = const Text('Fri', style: style);
        break;
      case 7:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  final user = FirebaseAuth.instance.currentUser!;
  double progress = 0.5;
  String displayName = "user";

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (user.displayName == null) {
      displayName = user.email.toString();
    } else {
      setState(() {
        displayName = user.displayName.toString();
      });
    }

    var media = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.white], // Your gradient colors
              begin: Alignment.topCenter, // Optional: starting point
              end: Alignment.bottomCenter, // Optional: ending point
              stops: [0.0, 0.7], // Optional: color stops
              tileMode: TileMode.clamp, // Optional: repeats the gradient
            ),
          ),
          child: SingleChildScrollView(
              child: SafeArea(
                  child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          user.photoURL != null && user.photoURL!.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    user.photoURL!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 20,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Welcome Back !",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  displayName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _signOut,
                        icon: Image.asset(
                          "assets/img/logout.png",
                          width: 25,
                          height: 25,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  Container(
                    height: media.width * 0.42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 230, 43, 66),
                          Color.fromARGB(255, 230, 43, 66)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(media.width * 0.075),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/img/abstract.png",
                          height: media.width * 0.4,
                          width: double.maxFinite,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Today Your Progress',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Text(
                                    "Let's get back on business",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.02,
                                  ),
                                  Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 181, 76, 76),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      splashColor:
                                          Colors.white.withOpacity(0.5),
                                      child: SizedBox(
                                        width: media.width * 0.3,
                                        height: media.width * 0.1,
                                        child: const Center(
                                          child: Text(
                                            'View Tasks',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Change this value to represent your progress

                              SizedBox(
                                child: CircularPercentIndicator(
                                  animation: true,
                                  radius: 60,
                                  lineWidth: 20,
                                  percent: progress,
                                  progressColor:
                                      Color.fromARGB(174, 254, 63, 63),
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 210, 210),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    '${(progress * 100).toInt()}%', // Show the percentage value
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  const Text(
                    ' Your Daily Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.02,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      height: media.width * 0.5,
                      width: double.maxFinite,
                      child: Stack(alignment: Alignment.topLeft, children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        LineChart(LineChartData(
                          lineTouchData: LineTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback: (FlTouchEvent event,
                                LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return;
                              }
                            },
                            mouseCursorResolver: (FlTouchEvent event,
                                LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return SystemMouseCursors.basic;
                              }
                              return SystemMouseCursors.click;
                            },
                            getTouchedSpotIndicator: (LineChartBarData barData,
                                List<int> spotIndexes) {
                              return spotIndexes.map((index) {
                                return TouchedSpotIndicatorData(
                                  const FlLine(
                                    color: Colors.pink,
                                  ),
                                  FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (spot, percent, barData, index) =>
                                            FlDotCirclePainter(
                                      radius: 8,
                                      color: Colors.blueGrey,
                                      strokeWidth: 2,
                                      strokeColor: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.pink,
                              tooltipRoundedRadius: 8,
                              getTooltipItems:
                                  (List<LineBarSpot> lineBarsSpot) {
                                return lineBarsSpot.map((lineBarSpot) {
                                  return LineTooltipItem(
                                    lineBarSpot.y.toString(),
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: lineBarsData1,
                          minY: -0.5,
                          maxY: 100,
                          titlesData: FlTitlesData(
                              show: true,
                              leftTitles: AxisTitles(),
                              topTitles: AxisTitles(),
                              bottomTitles:
                                  AxisTitles(sideTitles: bottomTitles),
                              rightTitles:
                                  AxisTitles(sideTitles: rightTitles())),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 18,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.grey.withOpacity(0.1),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                        )),
                      ])),
                ]),
          ))),
        ));
  }
}
