class Util {
  static String toDate(String timeMilli) {
    int s;
    try {
      s = int.parse(timeMilli);
      var d = DateTime.fromMillisecondsSinceEpoch(s, isUtc: true);
      return "${d.year} - ${d.month} - ${d.day}";
    } catch (e) {
      return "";
    }
  }

  static String toHour(String timeMilli) {
    try {
      int time = int.parse(timeMilli);
      int milliSecond = time % 1000;
      String disPlayMilliSecond = milliSecond >= 100
          ? milliSecond.toString()
          : milliSecond >= 10
              ? "0$milliSecond"
              : "00$milliSecond";
      int totalSec = time ~/ 1000;
      int hour = totalSec ~/ 3600;
      totalSec -= hour * 3600;
      int minute = totalSec ~/ 60;
      int second = totalSec % 60;
      return "${hour}h : ${minute}m : $second.${disPlayMilliSecond}s";
    } catch (e) {
      return "";
    }
  }
}
