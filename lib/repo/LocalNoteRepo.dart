import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:timer_note/data/dto/SubjectDto.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';

import '../data/data_source/LocaleFileSource.dart';
import 'AbstractNoteRepo.dart';

class LocalNoteRepo extends AbstractNoteRepo {
  late String storagePath;
  final LocaleFileSource localeFileSource;

  LocalNoteRepo(this.localeFileSource) {
    getStoragePath();
  }

  Future<void> getStoragePath() async {
    final directory = await getApplicationDocumentsDirectory();
    storagePath = directory.path;
  }

  Future<Directory> getStorageFile() async {
    return Directory("$storagePath/timerNote");
  }

  @override
  Future<bool> addNote(String subjectUid, NoteEntity note) async {
    String uid = note.uuid;
    return await localeFileSource.addNote(
        subjectUid, uid, jsonEncode(note.toJson()));
  }

  @override
  Future<bool> addSubject(String subjectUid, SubjectEntity subject) async {
    return await localeFileSource.writeSubjectInfo(
        subjectUid, jsonEncode(subject.toJson()));
  }

  @override
  Future<bool> deleteNote(String subjectUid) {
    // TODO: implement deleteNote
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteSubject(String subjectUid) async {
    try {
      await localeFileSource.deleteSubject(subjectUid);
      await localeFileSource.deleteNotes(subjectUid);
      log('sss success');
      return true;
    } catch(e) {
      log('sss error = $e');
      return false;
    }
  }

  @override
  Future<bool> editNote(String subjectUid, NoteEntity note) async {
    return await localeFileSource.editNote(
        subjectUid,
        note.uuid,
        jsonEncode(note.toJson())
    );
  }

  @override
  Future<List<NoteEntity>> getNotes(String subjectUid) async {
    return await localeFileSource.getNotes(subjectUid);
  }

  @override
  Future<List<SubjectEntity>> getSubjects() async {
    List<String> subjectInfoList = await localeFileSource.getSubjects();
    if (subjectInfoList.isEmpty) return [];

    List<SubjectEntity> subjects = [];
    for (var info in subjectInfoList) {
      var json = jsonDecode(info);
      subjects.add(SubjectEntity.fromDto(SubjectDto.fromJson(json)));
    }
    return subjects;
  }
}
