import 'package:flutter/material.dart';
import 'package:timer_note/value/MyString.dart';

class AlertNotificationDialog extends StatelessWidget {
  const AlertNotificationDialog(this.title, this.content, {Key? key})
      : super(key: key);
  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title!) : Container(),
      content: content != null ? Text(content!) : Container(),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(MyString.confirm),
        )
      ],
    );
  }
}