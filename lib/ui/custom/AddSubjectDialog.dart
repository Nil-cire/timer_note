import 'package:flutter/material.dart';
import 'package:timer_note/value/MyString.dart';

import '../../value/MyDimension.dart';

class AddSubjectDialog extends StatelessWidget {
  const AddSubjectDialog(this.onConfirm, {Key? key}) : super(key: key);
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController titleTextController = TextEditingController();

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
                const Text(MyString.enterCategoryTitle),
                TextFormField(
                    controller: titleTextController,
                    decoration: const InputDecoration(
                        hintText: MyString.enterCategoryInputHint),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return (MyString.enterSubjectTitleError);
                      }
                      return null;
                    }),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onConfirm.call(titleTextController.text);
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
