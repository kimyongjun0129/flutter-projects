import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const fiveMinutes = 300;
  List timeList = [900, 1200, 1500, 1800, 2100];
  int selectedTime = 3;
  late int selectNum = 2;
  bool selectCheck = false;

  bool isRunning = false;
  int totalRound = 0;

  int restSeconds = fiveMinutes;
  bool isResting = false;

  int totalGoal = 0;
  late Timer timer;
  late Timer restTiemr;

  bool isTimeSelect1 = false;
  bool isTimeSelect2 = false;
  bool isTimeSelect3 = true;
  bool isTimeSelect4 = false;
  bool isTimeSelect5 = false;

  void onTick(Timer timer) {
    if (selectedTime == 0) {
      setState(() {
        upGoalPoint(++totalRound);
        isRunning = false;
        selectedTime = timeList[selectNum];
      });
      timer.cancel();
      onRestTimer();
    } else {
      setState(() {
        selectedTime--;
      });
    }
  }

  void restTick(Timer timer) {
    if (restSeconds == 0) {
      setState(() {
        isResting = false;
        restSeconds = fiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        restSeconds--;
      });
    }
  }

  void onRestTimer() {
    restTiemr = Timer.periodic(
      const Duration(seconds: 1),
      restTick,
    );
    setState(() {
      isResting = true;
    });
  }

  void upGoalPoint(int round) {
    if (round == 4) {
      totalRound = 0;
      totalGoal++;
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      selectedTime = timeList[selectNum];
    });
  }

  void timeSelectPressed1() {
    if (!isTimeSelect1 && !isRunning && !isResting) {
      setState(() {
        isTimeSelect1 = true;
        isTimeSelect2 = false;
        isTimeSelect3 = false;
        isTimeSelect4 = false;
        isTimeSelect5 = false;
        selectNum = 0;
        selectedTime = timeList[0];
      });
    }
  }

  void timeSelectPressed2() {
    if (!isTimeSelect2 && !isRunning && !isResting) {
      setState(() {
        isTimeSelect2 = true;
        isTimeSelect1 = false;
        isTimeSelect3 = false;
        isTimeSelect4 = false;
        isTimeSelect5 = false;
        selectNum = 1;
        selectedTime = timeList[1];
      });
    }
  }

  void timeSelectPressed3() {
    if (!isTimeSelect3 && !isRunning && !isResting) {
      setState(() {
        isTimeSelect3 = true;
        isTimeSelect1 = false;
        isTimeSelect2 = false;
        isTimeSelect4 = false;
        isTimeSelect5 = false;
        selectNum = 2;
        selectedTime = timeList[2];
      });
    }
  }

  void timeSelectPressed4() {
    if (!isTimeSelect4 && !isRunning && !isResting) {
      setState(() {
        isTimeSelect4 = true;
        isTimeSelect1 = false;
        isTimeSelect2 = false;
        isTimeSelect3 = false;
        isTimeSelect5 = false;
        selectNum = 3;
        selectedTime = timeList[3];
      });
    }
  }

  void timeSelectPressed5() {
    if (!isTimeSelect5 && !isRunning && !isResting) {
      setState(() {
        isTimeSelect5 = true;
        isTimeSelect1 = false;
        isTimeSelect2 = false;
        isTimeSelect3 = false;
        isTimeSelect4 = false;
        selectNum = 4;
        selectedTime = timeList[4];
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Title
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.topLeft,
              child: const Text(
                "POMOTIMER",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),

          // Show Rest Time
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 시간 보여주는 UI
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 30,
                      ),
                      child: Text(
                        isResting
                            ? format(restSeconds).split(":").first
                            : format(selectedTime).split(":").first,
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    ":",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 30,
                      ),
                      child: Text(
                        isResting
                            ? format(restSeconds).split(":").last
                            : format(selectedTime).split(":").last,
                        style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),

          // 시간 정하기
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isTimeSelect1
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: timeSelectPressed1,
                      child: Text(
                        format(timeList[0]).split(":").first,
                        style: TextStyle(
                            color: isTimeSelect1
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isTimeSelect2
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: timeSelectPressed2,
                      child: Text(
                        format(timeList[1]).split(":").first,
                        style: TextStyle(
                            color: isTimeSelect2
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isTimeSelect3
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: timeSelectPressed3,
                      child: Text(
                        format(timeList[2]).split(":").first,
                        style: TextStyle(
                            color: isTimeSelect3
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isTimeSelect4
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: timeSelectPressed4,
                      child: Text(
                        format(timeList[3]).split(":").first,
                        style: TextStyle(
                            color: isTimeSelect4
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: isTimeSelect5
                          ? Colors.white
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: timeSelectPressed5,
                      child: Text(
                        format(timeList[4]).split(":").first,
                        style: TextStyle(
                            color: isTimeSelect5
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // 재생 & 일시정지
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Colors.white,
                onPressed: isResting
                    ? () {}
                    : (isRunning ? onPausePressed : onStartPressed),
                icon: Icon(
                  isResting
                      ? Icons.pause_circle_outline
                      : (isRunning
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline),
                ),
              ),
            ),
          ),

          // 리셋 버튼
          Flexible(
            flex: 1,
            child: Center(
              child: IconButton(
                iconSize: 60,
                color: Colors.white,
                onPressed: resetPressed,
                icon: const Icon(Icons.restore),
              ),
            ),
          ),

          // 목표 달성
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$totalRound/4',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                        ),
                      ),
                      Text(
                        'ROUND',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$totalGoal/12',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                        ),
                      ),
                      Text(
                        'GOAL',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.headlineLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
