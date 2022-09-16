import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/data/entity/NoteFileEntity.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../custom/NoteListItemView.dart';
import 'NoteListViewModel.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage(this.noteFile, {Key? key}) : super(key: key);
  final NoteFileEntity noteFile;

  @override
  State<NoteListPage> createState() => NoteListPageState();
}

class NoteListPageState extends State<NoteListPage> {
  late NoteListViewModel vm;

  @override
  Widget build(BuildContext context) {
    vm = NoteListViewModel(widget.noteFile.notes);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteFile.title),
      ),
      body: Container(
        child: BlocBuilder<NoteListViewModel, NoteListViewModelState>(
          bloc: vm,
          builder: (context, state) {
            switch (state) {
              case NoteListViewModelState.init:
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
          },
        ),
      ),
    );
  }
}
