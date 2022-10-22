import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

import '../../repo/AbstractNoteRepo.dart';

class TimerPageViewModel extends Cubit<TimerPageViewModelState> {
  TimerPageViewModel(this.noteEntity, this.abstractNoteRepo)
      : super(TimerPageViewModelState.init);
  AbstractNoteRepo abstractNoteRepo;
  NoteEntity noteEntity;

  Future<bool> updateScore(int newScore) async {
    noteEntity.scoreHistory.add(newScore);
    return await abstractNoteRepo.editNote(noteEntity.subjectUid, noteEntity);
  }
}

enum TimerPageViewModelState { init }
