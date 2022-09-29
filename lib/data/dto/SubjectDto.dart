
import 'package:json_annotation/json_annotation.dart';

import 'NoteDto.dart';

part 'SubjectDto.g.dart';

@JsonSerializable(explicitToJson: true)
class SubjectDto {
  String uuid;
  String title;
  List<NoteDto>? notes;

  SubjectDto(this.uuid, this.title, this.notes);

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectDtoToJson(this);
}