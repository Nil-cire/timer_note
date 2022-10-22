import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/ui/note_detail/NoteDetailViewModel.dart';

import '../../data/data_source/LocaleFileSource.dart';
import '../../data/entity/TimerTimeEntity.dart';
import '../../repo/LocalNoteRepo.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage(this.note, {Key? key}) : super(key: key);

  final NoteEntity note;

  @override
  State<StatefulWidget> createState() => NoteDetailPageState();
}

class NoteDetailPageState extends State<NoteDetailPage> {
  late NoteDetailViewModel vm;

  @override
  void dispose() {
    vm.close();
    super.dispose();
  }
  // late List<TextEditingController> extraTextControllers;

  // TextEditingController contentTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    vm = NoteDetailViewModel(widget.note, LocalNoteRepo(LocaleFileSource.getInstance));



    return Scaffold(
      appBar: AppBar(
        title: Text(vm.note.subject),
      ),
      body: BlocBuilder<NoteDetailViewModel, NoteDetailViewModelState>(
        bloc: vm,
        buildWhen: (context, state) {
          if (state == NoteDetailViewModelState.init ||
              state == NoteDetailViewModelState.update ||
              state == NoteDetailViewModelState.update2) {
            return true;
          }  else {
            return false;
          }
        },
        builder: (context, state) {
          int time = vm.note.timeSecond;

          int milliSecond = time % 1000;
          int totalSec = time ~/ 1000;
          int hour = totalSec ~/ 3600;
          totalSec -= hour * 3600;
          int minute = totalSec ~/ 60;
          int second = totalSec % 60;

          switch (state) {
            case NoteDetailViewModelState.init:
              return Container();
            case NoteDetailViewModelState.update:
            case NoteDetailViewModelState.update2:
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(hour.toString()),
                      Text(minute.toString()),
                      Text(second.toString())
                    ],
                  ),
                  Text(vm.note.content),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: buildExtraData(vm.note.customData),
                      ),
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                        onPressed: () {
                          log("sss detail note = ${widget.note.hashCode}");
                          Navigator.of(context).pushNamed('/timer', arguments: {
                            'note': widget.note,
                            'time': TimerTimeEntity(hour.toString(), minute.toString(),
                                second.toString(), milliSecond.toString())
                          }).then((value) {vm.updateNote();});
                        },
                        child: const Text("Start"),
                      ))
                ],
              );
            default: return Container();
          }
        }),
    );
  }

  List<Widget> buildExtraData(Map<String, String>? extraData) {
    List<Widget> extraDataViewList = [
      Text(vm.note.date),
      Text(vm.note.temperature ?? ""),
      Text(vm.note.weather ?? ""),
      Text(vm.note.score)
    ];
    if (extraData != null) {
      extraData.forEach((key, value) {
        extraDataViewList.add(Text(value));
      });
    }

    return extraDataViewList;
  }
}
