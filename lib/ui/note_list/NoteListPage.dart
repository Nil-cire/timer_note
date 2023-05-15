import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/data/data_source/LocaleFileSource.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/repo/LocalNoteRepo.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../../value/MyColor.dart';
import '../../value/MyString.dart';
import '../custom/AddNoteDialog.dart';
import '../custom/NoteListExpandItemView.dart';
import '../custom/NoteListItemView.dart';
import 'NoteListViewModel.dart';


const backGroundTextStyle = TextStyle(
  fontSize: 20,
  color: MyColor.textOnPrimaryColor,
);

class NoteListPage extends StatefulWidget {
  const NoteListPage(this.subjectInfo, {Key? key}) : super(key: key);
  final SubjectEntity subjectInfo;

  @override
  State<NoteListPage> createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  late NoteListViewModel vm;


  @override
  void dispose() {
    vm.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    vm = NoteListViewModel(
        widget.subjectInfo.uuid, LocalNoteRepo(LocaleFileSource.getInstance));

    return Scaffold(
      backgroundColor: MyColor.secondaryColor,
      appBar: AppBar(
        title: Text(widget.subjectInfo.title),
        backgroundColor: MyColor.primaryColor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) {
              var index = -1;
              List<String> optionList = ["Title", "Time", "Score"];
              return optionList.map((option) {
                index ++;
                return PopupMenuItem(
                  value: index,
                  child: Text(option),
                );
              }).toList();
            },
            onSelected: (value) {
              switch (value) {
                case 0: { // title
                  vm.sortNotes(NoteSortType.title);
                  break;
                }
                case 1: { // time
                  vm.sortNotes(NoteSortType.time);
                  break;
                }
                case 2 : { // score
                  vm.sortNotes(NoteSortType.score);
                  break;
                }
                default: {}
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddNoteDialog(
                      widget.subjectInfo.uuid,
                      (note) {vm.addNote(note);}
                    );
                  });
            },
          )
        ],
      ),
      body: Container(
        // padding: const EdgeInsets.only(bottom: MyDimension.mainPadding),
        child: BlocBuilder<NoteListViewModel, NoteListViewModelState>(
          bloc: vm,
          buildWhen: (context, state) {
            return (state == NoteListViewModelState.init ||
                state == NoteListViewModelState.noteUpdate ||
                state == NoteListViewModelState.noteUpdate2
            );
          },
          builder: (context, state) {
            switch (state) {
              case NoteListViewModelState.init:
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(MyString.noNote, style: backGroundTextStyle),
                  ),
                );
              case NoteListViewModelState.noteUpdate:
              case NoteListViewModelState.noteUpdate2:
                if (vm.notes.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text(MyString.noNote, style: backGroundTextStyle),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: vm.notes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapUp: (tapUpDetails) {
                            Navigator.of(context).pushNamed('/note_detail',
                                arguments: {'note_detail': vm.notes[index]})
                                .then((value) => () {
                                  vm.getNotes();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MyDimension.mainPadding,
                                top: (index==0) ? MyDimension.mainPadding : 0.0,
                                bottom: MyDimension.mainPadding,
                                right: MyDimension.mainPadding),
                            child: NoteListExpandItemView(
                                vm.notes[index],
                                () { vm.deleteNote(vm.notes[index]); }
                            ),
                          ),
                        );
                      });
                }
            }
          },
        ),
      ),
    );
  }
}
