import 'package:timer_note/data/entity/NoteEneity.dart';

class NoteFileEntity {
  String uuid;
  String title;
  List<NoteEntity> notes;

  NoteFileEntity(this.uuid, this.title, this.notes);
}
