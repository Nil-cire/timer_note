import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEneity.dart';
import 'package:timer_note/ui/note_detail/NoteDetailViewModel.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage(this.note, {Key? key}) : super(key: key);

  final NoteEntity note;

  @override
  State<StatefulWidget> createState() => NoteDetailPageState();
}

class NoteDetailPageState extends State<NoteDetailPage> {
  late NoteDetailViewModel vm;

  // late List<TextEditingController> extraTextControllers;

  // TextEditingController contentTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();
  // TextEditingController hourTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    vm = NoteDetailViewModel(widget.note);
    // if (vm.note.customData != null) {
    //   vm.note.customData!.forEach((key, value) {
    //     extraTextControllers.add(TextEditingController(text: value));
    //   });
    // }

    int hour = vm.note.timeSecond / 60 ~/ 60;
    int min = vm.note.timeSecond % 3600 ~/ 60;
    int sec = (vm.note.timeSecond % 216000);

    return Scaffold(
      appBar: AppBar(
        title: Text(vm.note.subject),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(hour.toString()),
              Text(min.toString()),
              Text(sec.toString())
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
                onPressed: () {},
                child: const Text("Start"),
              )
          )
        ],
      ),
    );
  }

  List<Widget> buildExtraData(Map<String, String>? extraData) {
    List<Widget> extraDataViewList = [
      Text(vm.note.date),
      Text(vm.note.temperature),
      Text(vm.note.weather),
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
