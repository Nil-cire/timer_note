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
    emit(NoteListViewModelState.noteUpdate);
  }

  void addNote(NoteEntity noteEntity) async {
    await abstractNoteRepo.addNote(subjectUid, noteEntity);
    getNotes();
  }
}

enum NoteListViewModelState {
  init,
  noteUpdate,
}
