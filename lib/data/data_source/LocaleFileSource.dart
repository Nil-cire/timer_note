import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:timer_note/data/dto/NoteDto.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

class LocaleFileSource {
  static String storagePath = "";
  static const String appPath = "timerNote";

  static LocaleFileSource getInstance = LocaleFileSource._getInstance();

  static Future<void> init() async {
    await _initStoragePath();
  }

  LocaleFileSource._getInstance() {
    if (storagePath.isEmpty) _initStoragePath();
  }

  static Future<void> _initStoragePath() async {
    final directory = await getApplicationDocumentsDirectory();
    storagePath = directory.path;
  }

  Future<Directory> _getSubjectDirectory() async {
    return Directory("$storagePath/$appPath").create(recursive: true);
  }

  Future<List<File>> _getSubjectInfoFiles() async {
    Directory directory = await _getSubjectDirectory();
    List<FileSystemEntity> entities = directory.listSync();

    List<File> files = [];
    for (var entity in entities) {
      if (entity is File) {
        files.add(entity);
      }
    }
    return files;
  }

  Future<File> _getSubjectFile(String subjectUid) async {
    return File("$storagePath/$appPath/$subjectUid.txt")
        .create(recursive: true);
  }

  Future<Directory?> _getNoteDirectory(String subjectUid) async {
    return await Directory("$storagePath/$appPath/$subjectUid")
        .create(recursive: true);
  }

  Future<List<File>> _getNoteFiles(String subjectUid) async {
    Directory? directory = await _getNoteDirectory(subjectUid);
    List<FileSystemEntity>? entities = directory?.listSync();

    if (entities == null || entities.isEmpty) return [];

    List<File> notes = [];
    for (var entity in entities) {
      if (entity is File) {
        notes.add(entity);
      }
    }

    return notes;
  }

  Future<File> _getNoteFile(String subjectUid, String noteUid) async {
    return File("$storagePath/$appPath/$subjectUid/$noteUid.txt");
  }

  Future<List<String>> getSubjects() async {
    List<File>? files = await _getSubjectInfoFiles();
    if (files.isEmpty == true) return [];

    List<String> subjectInfoList = [];

    for (var file in files) {
      String info = await file.readAsString();
      subjectInfoList.add(info);
    }

    return subjectInfoList;
  }

  Future<String> getSubject(String subjectUid) async {
    File file = await _getSubjectFile(subjectUid);
    return await file.readAsString();
  }

  Future<List<NoteEntity>> getNotes(String subjectUid) async {
    List<File> files = await _getNoteFiles(subjectUid);
    List<NoteEntity> noteList = [];
    if (files.isEmpty) return [];

    for (var file in files) {
      String info = await file.readAsString();
      Map<String, dynamic> json = jsonDecode(info);
      noteList.add(NoteEntity.fromDto(NoteDto.fromJson(json)));
    }

    return noteList;
  }

  Future<NoteEntity> getNote(String subjectUid, String noteUid) async {
    File file = await _getNoteFile(subjectUid, noteUid);
    String info = await file.readAsString();
    return NoteEntity.fromDto(NoteDto.fromJson(jsonDecode(info)));
  }

  Future<bool> addNote(String subjectUid, String noteUid, String note) async {
    File file = await File("$storagePath/$appPath/$subjectUid/$noteUid.txt")
        .create(recursive: true);
    try {
      file.writeAsString(note);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> writeSubjectInfo(String subjectUid, String data) async {
    try {
      File subjectFile = await _getSubjectFile(subjectUid);
      subjectFile.writeAsString(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSubject(String subjectUid) async {
    try {
      File file = await _getSubjectFile(subjectUid);
      file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNotes(String subjectUid) async {
    try {
      Directory? directory = await _getNoteDirectory(subjectUid);
      directory?.delete(recursive: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote(String subjectUid, String noteUid) async {
    try {
      File file = await _getNoteFile(subjectUid, noteUid);
      file.delete();
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<bool> editNote(String subjectUid, String noteUid, String data) async {
    try {
      File file = await _getNoteFile(subjectUid, noteUid);
      file.writeAsString(data, mode: FileMode.write);
      return true;
    } catch(e) {
      return false;
    }
  }
}
