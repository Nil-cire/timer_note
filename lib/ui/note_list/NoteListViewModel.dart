import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

import '../../repo/AbstractNoteRepo.dart';

class NoteListViewModel extends Cubit<NoteListViewModelState> {
  String subjectUid;
  AbstractNoteRepo abstractNoteRepo;
  List<NoteEntity> notes = [];

  int titleSort = 0;
  int timeSort = 0;
  int scoreSort = 0;

  NoteListViewModel(this.subjectUid, this.abstractNoteRepo)
      : super(NoteListViewModelState.init) {
    getNotes();
  }

  void sortNotes(NoteSortType subjectsSortType) {
    switch (subjectsSortType) {
      case NoteSortType.title: {
        if (titleSort == 0) {
          notes.sort((a, b) => a.subject.compareTo(b.subject));
          _emitNoteUpdate();
          titleSort = 1;
        } else {
          notes.sort((a, b) => b.subject.compareTo(a.subject));
          _emitNoteUpdate();
          titleSort = 0;
        }
        break;
      }
      case NoteSortType.time: {
        if (timeSort == 0) {
          notes.sort((a, b) => b.timeSecond.compareTo(a.timeSecond));
          _emitNoteUpdate();
          timeSort = 1;
        } else {
          notes.sort((a, b) => a.timeSecond.compareTo(b.timeSecond));
          _emitNoteUpdate();
          timeSort = 0;
        }
        break;
      }
      case NoteSortType.score: {
        if (scoreSort == 0) {
          notes.sort((a, b) => b.score.compareTo(a.score));
          _emitNoteUpdate();
          scoreSort = 1;
        } else {
          notes.sort((a, b) => a.score.compareTo(b.score));
          _emitNoteUpdate();
          scoreSort = 0;
        }
        break;
      }
    }
  }

  void getNotes() async {
    notes = await abstractNoteRepo.getNotes(subjectUid);
    _emitNoteUpdate();
  }

  void addNote(NoteEntity noteEntity) async {
    await abstractNoteRepo.addNote(subjectUid, noteEntity);
    getNotes();
  }

  void _emitNoteUpdate() {
    if (state == NoteListViewModelState.noteUpdate) {
      emit(NoteListViewModelState.noteUpdate2);
    } else {
      emit(NoteListViewModelState.noteUpdate);
    }
  }

  void deleteNote(NoteEntity note) async {
    await abstractNoteRepo.deleteNote(note.subjectUid, note.uuid);
    getNotes();
  }
}

enum NoteListViewModelState {
  init,
  noteUpdate, noteUpdate2
}

enum NoteSortType {
  title, time, score
}
