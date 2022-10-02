import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/TimerTimeEntity.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({this.countdownTime, Key? key}) : super(key: key);
  final TimerTimeEntity? countdownTime;

  @override
  State<TimerPage> createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> {
  int oldTime = 0;
  late int time;

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
            children: [
              Row(
                children: [
                  Flexible(child: Text(hour.toString())),
                  Flexible(
                      child:
                          Text(minute > 10 ? minute.toString() : "0$minute")),
                  Flexible(
                      child:
                          Text(second > 10 ? second.toString() : "0$second")),
                  Flexible(
                      child: Text(milliSecond > 100
                          ? milliSecond.toString()
                          : milliSecond > 10
                              ? "0$milliSecond"
                              : "00$milliSecond")),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: IconButton(
                    icon: const Icon(Icons.undo),
                    onPressed: () {},
                  )),
                  Flexible(
                      child: IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      _startCountdown();
                    },
                  )),
                ],
              )
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

  void _zeroTime() {
    hour = 0;
    minute = 0;
    second = 0;
    milliSecond = 0;
  }

  void _startCountdown() async {
    oldTime = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      var newTime = DateTime.now().millisecondsSinceEpoch;
      var currentCountdownTime = time - (newTime - oldTime);
      if (currentCountdownTime < 0) {
        _zeroTime();
        timer.cancel();
      } else {
        _emitTimeChange(currentCountdownTime);
      }
    });
  }
}
