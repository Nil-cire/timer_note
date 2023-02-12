import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/util.dart';

import '../../value/MyDimension.dart';

class HomeNoteView extends StatelessWidget {
  const HomeNoteView(this.noteFile, this.onDelete, {Key? key}) : super(key: key);

  final SubjectEntity noteFile;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(MyDimension.mainBorderRadius)),
      child: Container(
          padding: const EdgeInsets.all(MyDimension.itemMainPadding),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noteFile.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: MyDimension.fontSizeItemTitle),
              ),
              Container(height: 12,),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (noteFile.notes.length <= 1)
                            ? "${noteFile.notes.length} note"
                            : "${noteFile.notes.length} notes",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: MyDimension.fontSizeItemContent),
                      ),
                      Text(
                        Util.toDate(noteFile.uuid),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: MyDimension.fontSizeItemContent),
                      ),
                    ],
                  )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Confirm delete \"${noteFile.title}\"?"),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text("Cancel")),
                                  ElevatedButton(onPressed: (){
                                    onDelete.call(noteFile.uuid);
                                    Navigator.of(context).pop();
                                  }, child: Text("Confirm")),
                                ],
                              );
                            }
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          )),
    );
  }
}
