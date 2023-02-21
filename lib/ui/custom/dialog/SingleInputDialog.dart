
import 'package:flutter/material.dart';
import 'package:timer_note/value/MyColor.dart';

import '../../../value/MyDimension.dart';
import '../../../value/MyString.dart';

class SingleInputDialog extends StatelessWidget {
  const SingleInputDialog(this.onConfirm, {Key? key, this.title = "", this.content = "", this.inputHint = ""}) : super(key: key);
  final String title;
  final String content;
  final String inputHint;
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    TextEditingController inputTextController = TextEditingController();

    return Dialog(
      child: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(MyDimension.mainBorderRadius)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: MyDimension.dialogOuterPadding,
                horizontal: MyDimension.dialogOuterPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: title.isNotEmpty,
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 22, color: MyColor.dialogTextColor),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Visibility(
                  visible: content.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: MyDimension.dialogInnerPadding),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        content,
                        style: const TextStyle(fontSize: 18, color: MyColor.dialogTextColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: MyDimension.dialogInnerPadding),
                  child: TextField(
                    controller: inputTextController,
                    decoration: InputDecoration(hintText: inputHint),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () { Navigator.of(context).pop(); },
                      style: ElevatedButton.styleFrom(
                          primary: MyColor.emphasizeColor,
                          onPrimary: MyColor.dialogButtonTextColor
                      ),
                      child: const Text(MyString.cancel)
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          if (inputTextController.text.isNotEmpty) {
                            onConfirm.call(inputTextController.text);
                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: MyColor.emphasizeColor, 
                            onPrimary: MyColor.dialogButtonTextColor
                        ),
                        child: const Text(MyString.confirm)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}