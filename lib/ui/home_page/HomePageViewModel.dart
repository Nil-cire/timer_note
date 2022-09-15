import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteFileEntity.dart';

import '../../data/entity/NoteEneity.dart';

class HomePageViewModel extends Cubit<HomePageViewModelState> {
  List<NoteFileEntity> noteFiles = [
    NoteFileEntity("uuid1", "title1", [NoteEntity("uuid11", "name11"), NoteEntity("uuid111", "name111")]),
    NoteFileEntity("uuid11", "title11", [NoteEntity("uuid22", "name22"), NoteEntity("uuid222", "name222")])
  ]; //todo mock data

  HomePageViewModel() : super(HomePageViewModelState.init) {
    getMainNotes();
  }

  Future<void> getMainNotes() async {
    emit(HomePageViewModelState.getMainNotesSuccess);
  }
}

enum HomePageViewModelState { init, getMainNotesSuccess }
