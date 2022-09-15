import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteFileEntity.dart';

import '../../value/MyDimension.dart';

class HomeNoteView extends StatelessWidget {
  const HomeNoteView(this.noteFile, {Key? key}) : super(key: key);

  final NoteFileEntity noteFile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
          Radius.circular(MyDimension.mainBorderRadius)),
      child: AspectRatio(
        aspectRatio: 1 / 2,
        child: Container(
          padding: const EdgeInsets.all(MyDimension.itemMainPadding),
          color: Colors.red,
        ),
      ),
    );
  }
}
