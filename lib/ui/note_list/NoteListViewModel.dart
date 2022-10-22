import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

import '../../repo/AbstractNoteRepo.dart';

class NoteListViewModel extends Cubit<NoteListViewModelState> {
  String subjectUid;
  AbstractNoteRepo abstractNoteRepo;
  List<NoteEntity> notes = [];

  NoteListViewModel(this.subjectUid, this.abstractNoteRepo)
      : super(NoteListViewModelState.init) {
    getNotes();
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
}

enum NoteListViewModelState {
  init,
  noteUpdate, noteUpdate2
}
