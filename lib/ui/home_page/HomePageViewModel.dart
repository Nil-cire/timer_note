import 'package:bloc/bloc.dart';
import 'package:timer_note/data/entity/NoteFileEntity.dart';

import '../../data/entity/NoteEneity.dart';

class HomePageViewModel extends Cubit<HomePageViewModelState> {
  List<NoteFileEntity> noteFiles = [
    NoteFileEntity("uuid1", "title1",
        [
          NoteEntity(
            "this.uuid",
            "this.subject",
            "this.content",
            1000000,
            "this.date",
            "this.temperature",
            "this.weather",
            "this.score",
          ),
          NoteEntity(
            "this.uuid",
            "this.subject",
            "this.content",
            1000000,
            "this.date",
            "this.temperature",
            "this.weather",
            "this.score",
          )
        ]),
    NoteFileEntity("uuid11", "title2",
        [
          NoteEntity(
            "this.uuid",
            "this.subject",
            "this.content",
            1000000,
            "this.date",
            "this.temperature",
            "this.weather",
            "this.score",
          ),
          NoteEntity(
            "this.uuid",
            "this.subject",
            "this.content",
            1000000,
            "this.date",
            "this.temperature",
            "this.weather",
            "this.score",
          )
        ])
  ]; //todo mock data

  HomePageViewModel() : super(HomePageViewModelState.init) {
    getMainNotes();
  }

  Future<void> getMainNotes() async {
    emit(HomePageViewModelState.getMainNotesSuccess);
  }
}

enum HomePageViewModelState { init, getMainNotesSuccess }
