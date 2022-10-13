import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/TimerTimeEntity.dart';

import '../custom/TimeUnitView.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({this.countdownTime, Key? key}) : super(key: key);
  final TimerTimeEntity? countdownTime;

  @override
  State<TimerPage> createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  int oldTime = 0;
  late int time;
  bool isTimerPause = true;

  int hour = 0;
  int minute = 1;
  int second = 0;
  int milliSecond = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
      ),
      body: Container(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 8,),
              Row(
                children: [
                  const Spacer(flex: 10,),
                  TimeUnitVew(hour > 10 ? hour.toString() : "0$hour", "Hour"),
                  const Spacer(flex: 3,),
                  TimeUnitVew(minute > 10 ? minute.toString() : "0$minute", "Minute"),
                  const Spacer(flex: 10,),
                ],
              ),
              Container(height: 40,),
              Row(
                children: [
                  const Spacer(flex: 10,),
                  TimeUnitVew(second > 10 ? second.toString() : "0$second", "Second"),
                  const Spacer(flex: 3,),
                  TimeUnitVew(milliSecond > 100
                      ? milliSecond.toString()
                      : milliSecond > 10
                      ? "0$milliSecond"
                      : "00$milliSecond", "MilliSecond"),
                  const Spacer(flex: 10,),
                ],
              ),
              // Row(
              //   children: [
              //     Flexible(child: Text(hour.toString())),
              //     Flexible(
              //         child:
              //             Text(minute > 10 ? minute.toString() : "0$minute")),
              //     Flexible(
              //         child:
              //             Text(second > 10 ? second.toString() : "0$second")),
              //     Flexible(
              //         child: Text(milliSecond > 100
              //             ? milliSecond.toString()
              //             : milliSecond > 10
              //                 ? "0$milliSecond"
              //                 : "00$milliSecond")),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    const Spacer(flex: 10,),
                    IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: 40,
                      onPressed: () {
                    _resetTime();
                      },
                    ),
                    Container(width: 40,),
                    isTimerPause
                        ? IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 40,
                        onPressed: () {
                          _pauseOrResumeCountdown();
                        },
                          )
                        : IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 40,
                        onPressed: () {
                          _pauseOrResumeCountdown();
                        },
                          ),
                    const Spacer(flex: 10,),
                  ],
                ),
              ),
              const Spacer(flex: 10,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    time = widget.countdownTime?.toTenMilliSec() ?? 0;
    _initDisplayTime();
  }

  void _initDisplayTime() {
    if (widget.countdownTime != null) {
      try {
        hour = int.parse(widget.countdownTime?.hour ?? "0");
        minute = int.parse(widget.countdownTime?.minute ?? "0");
        second = int.parse(widget.countdownTime?.second ?? "0");
        milliSecond = int.parse(widget.countdownTime?.tenMilliSecond ?? "0");
      } catch (e) {}
    }
  }

  void _updateDisplayValue(int displayTimeInTenMilli) {
    int time = displayTimeInTenMilli;
    milliSecond = time % 1000;
    int totalSec = time ~/ 1000;
    hour = totalSec ~/ 3600;
    totalSec -= hour * 3600;
    minute = totalSec ~/ 60;
    second = totalSec % 60;
  }

  void _emitTimeChange(int displayTimeMilli) async {
    if (mounted) {
      setState(() {
        _updateDisplayValue(displayTimeMilli);
      });
    }
  }

  void _zeroDisplayTime() {
    hour = 0;
    minute = 0;
    second = 0;
    milliSecond = 0;
  }

  void _pauseOrResumeCountdown() {
    if (isTimerPause) {
      _startCountdown(time);
    }
    setTimerPause(!isTimerPause);
  }

  void _startCountdown(int remainTime) async {
    oldTime = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      var newTime = DateTime.now().millisecondsSinceEpoch;
      var currentCountdownTime = remainTime - (newTime - oldTime);

      if (isTimerPause) {
        time = currentCountdownTime;
        timer.cancel();
      }

      if (currentCountdownTime < 0) {
        setTimerPause(true);
        _zeroDisplayTime();
        timer.cancel();
      } else {
        _emitTimeChange(currentCountdownTime);
      }
    });
  }

  void _resetTime() async {
    setTimerPause(true);
    await Future.delayed(const Duration(microseconds: 300));
    time = widget.countdownTime?.toTenMilliSec() ?? 0;
    _emitTimeChange(time);
  }

  void setTimerPause(bool isPause) {
    setState(() {
      isTimerPause = isPause;
    });
  }
}
