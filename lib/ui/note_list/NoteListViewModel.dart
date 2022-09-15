
import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteEneity.dart';

class NoteListViewModel extends Cubit<NoteListViewModelState> {

  List<NoteEntity> notes;

  NoteListViewModel(this.notes): super(NoteListViewModelState.init);

}

enum NoteListViewModelState {
  init
}