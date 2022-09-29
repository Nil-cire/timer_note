import 'dart:convert';

import '../dto/NoteDto.dart';

class NoteEntity {
  NoteEntity(this.uuid, this.subject, this.content, this.timeSecond, this.date,
      this.temperature, this.weather, this.score,
      {this.customData});

  String uuid;
  String subject;
  String content;
  int timeSecond;
  String date;
  String? temperature;
  String? weather;
  String score;
  Map<String, String>? customData;

  Map<String, dynamic> toJson() {
    var c = customData == null ? null : jsonEncode(customData);
    return {
      "uuid": uuid,
      "subject": subject,
      "content": content,
      "timeSecond": timeSecond,
      "date": date,
      "temperature": temperature,
      "weather": weather,
      "score": score,
      "customData": c
    };
  }

  factory NoteEntity.fromDto(NoteDto noteDto) {
    return NoteEntity(
        noteDto.uuid,
        noteDto.subject,
        noteDto.content,
        noteDto.timeSecond,
        noteDto.date,
        noteDto.temperature,
        noteDto.weather,
        noteDto.score,
        customData: noteDto.customData);
  }
}
