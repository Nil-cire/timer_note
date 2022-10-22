import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/util.dart';
import 'package:timer_note/value/MyColor.dart';

import '../../value/MyDimension.dart';

class NoteListExpandItemView extends StatefulWidget {
  const NoteListExpandItemView(this.note, {Key? key}) : super(key: key);
  final NoteEntity note;

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
        color: Colors.blue,
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
                            color: Colors.white,
                            fontSize: MyDimension.fontSizeItemTitle),
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isExpand = !isExpand;
                            });
                          },
                          icon: isExpand
                              ? const Icon(Icons.arrow_drop_down, color: MyColor.white)
                              : const Icon(Icons.arrow_drop_up, color: MyColor.white))
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
                                    color: Colors.white,
                                    fontSize: MyDimension.fontSizeItemContent)),
                            Text("Score : ${widget.note.score}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: MyDimension.fontSizeItemContent)),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete, color: MyColor.white,))
                    ],
                  )
                ],
              ),
            ),
            Visibility(
              visible: isExpand,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: MyColor.white,
                      margin: const EdgeInsets.only(top: 8, bottom: 16),
                    ),
                    Text(widget.note.content,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: MyDimension.fontSizeItemContent))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
