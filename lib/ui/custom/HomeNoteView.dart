import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/SubjectEntity.dart';

import '../../value/MyDimension.dart';

class HomeNoteView extends StatelessWidget {
  const HomeNoteView(this.noteFile, {Key? key}) : super(key: key);

  final SubjectEntity noteFile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(MyDimension.mainBorderRadius)),
      child: Container(
        padding: const EdgeInsets.all(MyDimension.itemMainPadding),
        color: Colors.blue,
        child: Text(
          noteFile.title,
          style: const TextStyle(
              color: Colors.white, fontSize: MyDimension.fontSizeItemTitle),
        ),
      ),
    );
  }
}
