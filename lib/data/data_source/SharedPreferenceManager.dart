
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {

  static const String subject = "subject";
  static const String note = "note";

  static Future<String?> getRecentSubjectUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(subject);
  }

  static Future<bool> setRecentSubjectUid(String subjectUid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(subject, subjectUid);
  }
}