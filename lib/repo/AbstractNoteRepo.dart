
import 'dart:ffi';

import 'package:timer_note/data/entity/SubjectEntity.dart';

import '../data/entity/NoteEntity.dart';

abstract class AbstractNoteRepo {

  Future<List<SubjectEntity>> getSubjects();
  Future<bool> addSubject(String subjectUid, SubjectEntity subject);
  Future<bool> deleteSubject(String subjectUid);

  Future<List<NoteEntity>> getNotes(String subjectUid);
  Future<bool> addNote(String subjectUid, NoteEntity note);
  Future<bool> editNote(String subjectUid, NoteEntity note);
  Future<bool> deleteNote(String subjectUid);

}