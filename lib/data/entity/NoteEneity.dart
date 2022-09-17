
class NoteEntity {
  NoteEntity(
      this.uuid,
      this.subject,
      this.content,
      this.timeSecond,
      this.date,
      this.temperature,
      this.weather,
      this.score,
      {this.customData}
      );

  String uuid;
  String subject;
  String content;
  int timeSecond;
  String date;
  String temperature;
  String weather;
  String score;
  Map<String, String>? customData;
}