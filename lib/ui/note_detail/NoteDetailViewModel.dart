import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

class NoteDetailViewModel extends Cubit<NoteDetailViewModelState> {
  NoteDetailViewModel(this.note) : super(NoteDetailViewModelState.init);
  NoteEntity note;
}

enum NoteDetailViewModelState { init }
