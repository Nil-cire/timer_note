import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_note/data/entity/NoteEntity.dart';
import 'package:timer_note/value/MyDimension.dart';

import '../../value/MyString.dart';

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog(this.onConfirm, {Key? key}) : super(key: key);
  final Function(NoteEntity) onConfirm;

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
                    Flexible(
                      child: TextFormField(
                        controller: minuteTextController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteMinuteHint),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: secondTextController,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: MyString.addNoteSecondHint),
                      ),
                    ),
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
                          time = (int.parse(hourTextController.text) * 3600 +
                                      int.parse(minuteTextController.text) *
                                          60 +
                                      int.parse(secondTextController.text)) *
                                  1000 +
                              int.parse(millisecondTextController.text);
                        } catch (e) {
                          time = 0;
                        }

                        var date =
                            "${now.year.toString()}-${now.month.toString()}-${now.day.toString()}";

                        NoteEntity noteEntity = NoteEntity(
                            uid,
                            titleTextController.text,
                            contentTextController.text,
                            time,
                            date,
                            null,
                            null,
                            "0");
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
