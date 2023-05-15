import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/util.dart';
import 'package:timer_note/value/MyColor.dart';
import 'package:timer_note/value/MyString.dart';

import '../../value/MyDimension.dart';

class NoteListExpandItemView extends StatefulWidget {
  const NoteListExpandItemView(this.note, this.onDelete, {Key? key})
      : super(key: key);
  final NoteEntity note;
  final Function onDelete;

  @override
  State<NoteListExpandItemView> createState() => NoteListExpandItemViewState();
}

class NoteListExpandItemViewState extends State<NoteListExpandItemView> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
          padding: const EdgeInsets.all(MyDimension.itemMainPadding),
          color: MyColor.itemColor,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.edit_note,
                  color: MyColor.textOnItemColor,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      // upper part
                      child: Column(
                        children: [
                          Row(
                            // upper title
                            children: [
                              Expanded(
                                  child: Text(
                                widget.note.subject,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                    fontStyle: FontStyle.italic,
                                    color: MyColor.textOnItemColor,
                                    fontSize: MyDimension.fontSizeItemTitle),
                              )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isExpand = !isExpand;
                                    });
                                  },
                                  icon: isExpand
                                      ? const Icon(Icons.arrow_drop_down,
                                          color: MyColor.textOnItemColor)
                                      : const Icon(Icons.arrow_drop_up,
                                          color: MyColor.textOnItemColor))
                            ],
                          ),
                          Row(
                            // upper info
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Timer : ${Util.toHour(widget.note.timeSecond.toString())}",
                                        style: const TextStyle(
                                            color: MyColor.textOnItemColor,
                                            fontSize: MyDimension
                                                .fontSizeItemContent)),
                                    Text("Score : ${widget.note.score}",
                                        style: const TextStyle(
                                            color: MyColor.textOnItemColor,
                                            fontSize: MyDimension
                                                .fontSizeItemContent)),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                "Confirm delete \"${widget.note.subject}\"?"),
                                            actions: [
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: MyColor.emphasizeColor,
                                                    onPrimary: MyColor.textOnPrimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                      MyString.cancel)),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: MyColor.emphasizeColor,
                                                    onPrimary: MyColor.textOnPrimaryColor,
                                                  ),
                                                  onPressed: () {
                                                    widget.onDelete.call();
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                      MyString.confirm)),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: MyColor.textOnItemColor,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isExpand,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 1,
                              color: MyColor.textOnItemColor,
                              margin: const EdgeInsets.only(top: 8, bottom: 16),
                            ),
                            Text(widget.note.content,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: MyColor.textOnItemColor,
                                    fontSize: MyDimension.fontSizeItemContent))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
