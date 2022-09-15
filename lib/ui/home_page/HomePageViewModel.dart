import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteFileEntity.dart';

class HomePageViewModel extends Cubit<HomePageViewModelState> {
  List<NoteFileEntity> noteFiles = [
    NoteFileEntity("001"),
    NoteFileEntity("002")
  ]; //todo mock data

  HomePageViewModel() : super(HomePageViewModelState.init) {
    getMainNotes();
  }

  Future<void> getMainNotes() async {
    emit(HomePageViewModelState.getMainNotesSuccess);
  }
}

enum HomePageViewModelState { init, getMainNotesSuccess }
