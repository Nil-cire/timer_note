
import 'package:json_annotation/json_annotation.dart';

part 'NoteDto.g.dart';

@JsonSerializable(explicitToJson: true)
class NoteDto {
  String uuid;
  String subjectUid;
  String subject;
  String content;
  int timeSecond;
  String date;
  String? temperature;
  String? weather;
  String score;
  List<int> scoreHistory;
  Map<String, String>? customData;

  NoteDto(
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
      {this.customData}
      );



  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NoteDtoToJson(this);
}