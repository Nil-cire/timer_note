import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

import '../../repo/AbstractNoteRepo.dart';

class NoteDetailViewModel extends Cubit<NoteDetailViewModelState> {
  NoteDetailViewModel(this.note, this.abstractNoteRepo) : super(NoteDetailViewModelState.init) {
    _emitUpdate();
  }
  AbstractNoteRepo abstractNoteRepo;
  NoteEntity note;

  Future<bool> updateNote() async {
    note = await abstractNoteRepo.getNote(note.subjectUid, note.uuid);
    _emitUpdate();
    return true;
  }

  _emitUpdate() {
    if (state == NoteDetailViewModelState.update) {
      emit(NoteDetailViewModelState.update2);
    } else {
      emit(NoteDetailViewModelState.update);
    }
  }
}

enum NoteDetailViewModelState {
  init,
  update, update2,
}
