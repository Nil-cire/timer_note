import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/data/data_source/LocaleFileSource.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/repo/LocalNoteRepo.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../../value/MyString.dart';
import '../custom/AddNoteDialog.dart';
import '../custom/NoteListExpandItemView.dart';
import '../custom/NoteListItemView.dart';
import 'NoteListViewModel.dart';

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
      appBar: AppBar(
        title: Text(widget.subjectInfo.title),
        actions: [
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
                  child: Text(MyString.noNote),
                );
              case NoteListViewModelState.noteUpdate:
              case NoteListViewModelState.noteUpdate2:
                if (vm.notes.isEmpty) {
                  return const Center(
                    child: Text(MyString.noNote),
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
                            padding: const EdgeInsets.only(
                                left: MyDimension.mainPadding,
                                top: MyDimension.mainPadding,
                                right: MyDimension.mainPadding),
                            child: NoteListExpandItemView(vm.notes[index]),
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
