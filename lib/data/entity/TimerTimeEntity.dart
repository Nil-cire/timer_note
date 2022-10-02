import 'dart:developer';

class TimerTimeEntity {
  String hour;
  String minute;
  String second;
  String tenMilliSecond;

  TimerTimeEntity(this.hour, this.minute, this.second, this.tenMilliSecond);

  int toTenMilliSec() {
    int time = 0;
    try {
      int hour = int.parse(this.hour);
      int minute = int.parse(this.minute);
      int second = int.parse(this.second);
      int tenMilliSecond = int.parse(this.tenMilliSecond);
      time = (hour * 3600 + minute * 60 + second) * 1000 + tenMilliSecond;
    } catch (e) {
      log("sss TimerTimeEntity = toMilliSec error");
    }
    return time;
  }

  factory TimerTimeEntity.from(int milliSec) {
    int milliSecond = milliSec % 1000;
    int totalSec = milliSec ~/ 100;
    int hour = totalSec ~/ 3600;
    totalSec -= hour * 3600;
    int minute = totalSec ~/ 60;
    int second = totalSec % 60;

    return TimerTimeEntity(hour.toString(), minute.toString(),
        second.toString(), milliSecond.toString());
  }
}
