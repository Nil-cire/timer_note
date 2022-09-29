
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';

import '../../value/MyDimension.dart';

class NoteListItemView extends StatelessWidget {

  final NoteEntity note;

  const NoteListItemView(this.note, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
          Radius.circular(MyDimension.mainBorderRadius)),
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: Container(
          padding: const EdgeInsets.all(MyDimension.itemMainPadding),
          color: Colors.blue,
          child: Center(
            child: Text(note.subject),
          ),
        ),
      ),
    );
  }

}