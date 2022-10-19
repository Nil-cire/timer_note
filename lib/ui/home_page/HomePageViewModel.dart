import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/repo/AbstractNoteRepo.dart';

import '../../data/data_source/SharedPreferenceManager.dart';
import '../../data/entity/NoteEntity.dart';

class HomePageViewModel extends Cubit<HomePageViewModelState> {

  final AbstractNoteRepo _noteRepo;

  List<SubjectEntity> noteFiles = [
    // SubjectEntity("uuid1", "title1",
    //     [
    //       NoteEntity(
    //         "this.uuid",
    //         "this.subject",
    //         "this.content",
    //         1000000,
    //         "this.date",
    //         "this.temperature",
    //         "this.weather",
    //         "this.score",
    //       ),
    //       NoteEntity(
    //         "this.uuid",
    //         "this.subject",
    //         "this.content",
    //         1000000,
    //         "this.date",
    //         "this.temperature",
    //         "this.weather",
    //         "this.score",
    //       )
    //     ]),
    // SubjectEntity("uuid11", "title2",
    //     [
    //       NoteEntity(
    //         "this.uuid",
    //         "this.subject",
    //         "this.content",
    //         1000000,
    //         "this.date",
    //         "this.temperature",
    //         "this.weather",
    //         "this.score",
    //       ),
    //       NoteEntity(
    //         "this.uuid",
    //         "this.subject",
    //         "this.content",
    //         1000000,
    //         "this.date",
    //         "this.temperature",
    //         "this.weather",
    //         "this.score",
    //       )
    //     ])
  ]; //todo mock data

  SubjectEntity? recentSubject;
  int timeSort = 0;
  int titleSort = 0;

  HomePageViewModel(this._noteRepo) : super(HomePageViewModelState.init) {
    getSubjects();
  }

  Future<void> getSubjects() async {
    noteFiles = await _noteRepo.getSubjects();
    List<List<NoteEntity>> subjectNoteCount = [];
    for (var subject in noteFiles) {
      List<NoteEntity> notes = await _noteRepo.getNotes(subject.uuid);
      subjectNoteCount.add(notes);
    }
    for (int i = 0; i < subjectNoteCount.length; i++){
      noteFiles[i].notes.addAll(subjectNoteCount[i]);
    }
    noteFiles.sort((a, b) => b.uuid.compareTo(a.uuid)); // new (larger num) first

    var recentSubjectUid = await _getRecentSubjectUid();
    recentSubject = null;
    for (var element in noteFiles) {
      if (element.uuid == recentSubjectUid) {
        recentSubject = element;
        break;
      }
    }

    _emitSubjectUpdate();
  }

  Future<bool> _addSubject(String title) async {
    var uuid = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    SubjectEntity subjectEntity = SubjectEntity(uuid, title, []);
    return await _noteRepo.addSubject(uuid, subjectEntity);
  }

  void addSubjectAndUpdate(String title) async {
    var addSuccess = await _addSubject(title);
    if (addSuccess) {
      emit(HomePageViewModelState.addSuccess);
      await getSubjects();
    } else {
      emit(HomePageViewModelState.addFail);
    }
  }

  void _emitSubjectUpdate() {
    state == HomePageViewModelState.subjectUpdate
        ? emit(HomePageViewModelState.subjectUpdate2)
        : emit(HomePageViewModelState.subjectUpdate);
  }

  Future<String?> _getRecentSubjectUid() async {
    return await SharedPreferenceManager.getRecentSubjectUid();
  }

  Future<bool> setRecentSubjectUid(String subjectUid) async {
    await SharedPreferenceManager.setRecentSubjectUid(subjectUid);
    recentSubject = null;
    for (var element in noteFiles) {
      if (element.uuid == subjectUid) {
        recentSubject = element;
        break;
      }
    }
    _emitSubjectUpdate();
    return true;
  }

  void sortSubjects(SubjectsSortType subjectsSortType) {
    switch (subjectsSortType) {
      case SubjectsSortType.title: {
        if (titleSort == 0) {
          noteFiles.sort((a, b) => a.title.compareTo(b.title));
          _emitSubjectUpdate();
          titleSort = 1;
        } else {
          noteFiles.sort((a, b) => b.title.compareTo(a.title));
          _emitSubjectUpdate();
          titleSort = 0;
        }
        break;
      }
      case SubjectsSortType.createTime: {
        if (timeSort == 0) {
          noteFiles.sort((a, b) => b.uuid.compareTo(a.uuid));
          _emitSubjectUpdate();
          timeSort = 1;
        } else {
          noteFiles.sort((a, b) => a.uuid.compareTo(b.uuid));
          _emitSubjectUpdate();
          timeSort = 0;
        }
        break;
      }
    }
  }
}

enum SubjectsSortType {
  title,
  createTime
}

enum HomePageViewModelState {
  init,
  subjectUpdate,
  subjectUpdate2,
  addSuccess,
  addFail,
}
