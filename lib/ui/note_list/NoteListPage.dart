import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/data/data_source/LocaleFileSource.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/repo/LocalNoteRepo.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../../value/MyString.dart';
import '../custom/AddNoteDialog.dart';
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
        child: BlocBuilder<NoteListViewModel, NoteListViewModelState>(
          bloc: vm,
          buildWhen: (context, state) {
            return (state == NoteListViewModelState.init ||
                state == NoteListViewModelState.noteUpdate);
          },
          builder: (context, state) {
            switch (state) {
              case NoteListViewModelState.init:
                return const Center(
                  child: Text(MyString.noNote),
                );
              case NoteListViewModelState.noteUpdate:
                if (vm.notes.isEmpty) {
                  return const Center(
                    child: Text(MyString.noNote),
                  );
                } else {
                  log("sss build");
                  return ListView.builder(
                      itemCount: vm.notes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapUp: (tapUpDetails) {
                            Navigator.of(context).pushNamed('/note_detail',
                                arguments: {'note_detail': vm.notes[index]});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.all(MyDimension.mainPadding),
                            child: AspectRatio(
                              aspectRatio: 3 / 1,
                              child: NoteListItemView(vm.notes[index]),
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
