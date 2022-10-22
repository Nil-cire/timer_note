import 'dart:convert';

import '../dto/NoteDto.dart';

class NoteEntity {
  NoteEntity(
      this.uuid,
      this.subjectUid,
      this.subject,
      this.content,
      this.timeSecond,
      this.date,
      this.temperature,
      this.weather,
      this.score,
      this.scoreHistory,
      {this.customData});

  String subjectUid;
  String uuid;
  String subject;
  String content;
  int timeSecond;
  String date;
  String? temperature;
  String? weather;
  String score;
  List<int> scoreHistory;
  Map<String, String>? customData;

  Map<String, dynamic> toJson() {
    var c = customData == null ? null : jsonEncode(customData);
    return {
      "uuid": uuid,
      "subjectUid": subjectUid,
      "subject": subject,
      "content": content,
      "timeSecond": timeSecond,
      "date": date,
      "temperature": temperature,
      "weather": weather,
      "score": score,
      "scoreHistory": scoreHistory,
      "customData": c
    };
  }

  factory NoteEntity.fromDto(NoteDto noteDto) {
    return NoteEntity(
        noteDto.uuid,
        noteDto.subjectUid,
        noteDto.subject,
        noteDto.content,
        noteDto.timeSecond,
        noteDto.date,
        noteDto.temperature,
        noteDto.weather,
        noteDto.score,
        noteDto.scoreHistory,
        customData: noteDto.customData);
  }
}
