import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../../value/MyString.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog(this.subjectUid, this.onConfirm, {Key? key}) : super(key: key);
  final Function(NoteEntity) onConfirm;
  final String subjectUid;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var currentDay = DateTime.now();
    TextEditingController titleTextController = TextEditingController();
    TextEditingController contentTextController = TextEditingController();
    TextEditingController hourTextController = TextEditingController();
    TextEditingController minuteTextController = TextEditingController();
    TextEditingController secondTextController = TextEditingController();
    TextEditingController millisecondTextController = TextEditingController();
    TextEditingController yearTextController =
        TextEditingController(text: currentDay.year.toString());
    TextEditingController monthTextController =
        TextEditingController(text: currentDay.month.toString());
    TextEditingController dayTextController =
        TextEditingController(text: currentDay.day.toString());

    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
              right: MyDimension.itemMainPadding,
              left: MyDimension.itemMainPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(MyString.addNoteTitle),
                TextFormField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                        hintText: MyString.addNoteTitleHint),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return (MyString.addNoteTitleError);
                      }
                      return null;
                    }),
                TextFormField(
                  controller: contentTextController,
                  decoration: const InputDecoration(
                      hintText: MyString.addNoteContentHint),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: hourTextController,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteHourHint),
                      ),
                    ),
                    const Text(":"),
                    Flexible(
                      child: TextFormField(
                        controller: minuteTextController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteMinuteHint),
                      ),
                    ),
                    const Text(":"),
                    Flexible(
                      child: TextFormField(
                        controller: secondTextController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteSecondHint),
                      ),
                    ),
                    const Text(":"),
                    Flexible(
                      child: TextFormField(
                        controller: millisecondTextController,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteMillisecondHint),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var now = DateTime.now();

                        var uid = now.millisecondsSinceEpoch.toString();

                        var time = 0;
                        try {
                          String hour = hourTextController.text.isEmpty
                              ? "0"
                              : hourTextController.text;
                          String minute = minuteTextController.text.isEmpty
                              ? "0"
                              : minuteTextController.text;
                          String second = secondTextController.text.isEmpty
                              ? "0"
                              : secondTextController.text;
                          String milliSecond =
                              millisecondTextController.text.isEmpty
                                  ? "0"
                                  : millisecondTextController.text;
                          time = (int.parse(hour) * 3600 +
                                      int.parse(minute) * 60 +
                                      int.parse(second)) *
                                  1000 +
                              int.parse(milliSecond);
                        } catch (e) {
                          time = 0;
                        }

                        var date =
                            "${now.year.toString()}-${now.month.toString()}-${now.day.toString()}";

                        NoteEntity noteEntity = NoteEntity(
                            uid,
                            subjectUid,
                            titleTextController.text,
                            contentTextController.text,
                            time,
                            date,
                            null,
                            null,
                            "0",
                            []);
                        onConfirm.call(noteEntity);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(MyString.confirm))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
