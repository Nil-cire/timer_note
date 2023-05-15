import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';
import 'package:timer_note/util.dart';
import 'package:timer_note/value/MyColor.dart';

import '../../value/MyDimension.dart';

class HomeNoteView extends StatelessWidget {
  const HomeNoteView(this.noteFile, this.onDelete, {Key? key}) : super(key: key);

  final SubjectEntity noteFile;
  final Function(String) onDelete;
  static const Color textColor = MyColor.textOnItemColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(MyDimension.mainBorderRadius)),
      child: Container(
          padding: const EdgeInsets.all(MyDimension.itemMainPadding),
          color: MyColor.itemColor,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.folder,
                  color: textColor,
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noteFile.title,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontStyle: FontStyle.italic,
                            color: textColor,
                            fontSize: MyDimension.fontSizeItemTitle
                        ),
                      ),
                      Container(height: 4,),
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
                                        color: textColor,
                                        fontSize: MyDimension.fontSizeItemContent),
                                  ),
                                  Text( // display date
                                    Util.toDate(noteFile.uuid),
                                    style: const TextStyle(
                                        color: textColor,
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
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: MyColor.emphasizeColor,
                                                onPrimary: MyColor.textOnPrimaryColor,
                                              ),
                                              onPressed: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel")),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: MyColor.emphasizeColor,
                                                onPrimary: MyColor.textOnPrimaryColor,
                                              ),
                                              onPressed: (){
                                                onDelete.call(noteFile.uuid);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Confirm")),
                                        ],
                                      );
                                    }
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: MyColor.secondaryColor,
                              ))
                        ],
                      )
                    ],
                  )
              )
            ],
          )
      ),
    );
  }
}
