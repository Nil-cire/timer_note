
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
}