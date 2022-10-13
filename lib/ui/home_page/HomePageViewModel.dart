import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/repo/AbstractNoteRepo.dart';

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

  HomePageViewModel(this._noteRepo) : super(HomePageViewModelState.init) {
    _getSubjects();
  }

  Future<void> _getSubjects() async {
    noteFiles = await _noteRepo.getSubjects();
    noteFiles.sort((a, b) => b.uuid.compareTo(a.uuid)); // new (larger num) first
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
      await _getSubjects();
    } else {
      emit(HomePageViewModelState.addFail);
    }
  }

  void _emitSubjectUpdate() {
    state == HomePageViewModelState.subjectUpdate
        ? emit(HomePageViewModelState.subjectUpdate2)
        : emit(HomePageViewModelState.subjectUpdate);
  }

  void sortSubjects(SubjectsSortType subjectsSortType) {
    switch (subjectsSortType) {
      case SubjectsSortType.title: {
        noteFiles.sort((a, b) => a.title.compareTo(b.title));
        _emitSubjectUpdate();
        break;
      }
      case SubjectsSortType.createTime: {
        noteFiles.sort((a, b) => b.uuid.compareTo(a.uuid));
        _emitSubjectUpdate();
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
