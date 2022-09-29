import 'dart:convert';

import 'package:timer_note/data/dto/SubjectDto.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

class SubjectEntity {
  String uuid;
  String title;
  List<NoteEntity> notes;

  SubjectEntity(this.uuid, this.title, this.notes);

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "title": title,
      "notes": notes.map((e) => jsonEncode(e.toJson())).toList()
    };
  }

  factory SubjectEntity.fromDto(SubjectDto noteFileDto) {
    List<NoteEntity> notes = [];
    noteFileDto.notes?.forEach((element) {
      notes.add(NoteEntity.fromDto(element));
    });

    return SubjectEntity(noteFileDto.uuid, noteFileDto.title, notes);
  }
}
