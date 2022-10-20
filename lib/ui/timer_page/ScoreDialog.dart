import 'package:flutter/material.dart';
import 'package:timer_note/value/MyDimension.dart';

class ScoreDialog extends StatelessWidget {
  ScoreDialog({Key? key, required this.onEnterScore}) : super(key: key);
  final Function(int) onEnterScore;
  final TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text("Complete!", style: TextStyle(fontSize: MyDimension.fontDialogTitle),),
              ),
              const Text("Score this result?", style: TextStyle(fontSize: MyDimension.fontDialogContent),),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextFormField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter number between 0-100"),
                  maxLength: 3,
                  validator: (text) {
                    int score = 0;
                    if (text == null) return "Invalid input";
                    try {
                      score = int.parse(text);
                    } catch (e) {
                      return "Invalid input";
                    }
                    if (score > 100 || score <0) return "Enter number between 1-100";
                    return null;
                  },
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: const Text("Cancel", style: TextStyle(fontSize: MyDimension.fontDialogButton),)),
                  Container(width: 10,),
                  ElevatedButton(onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onEnterScore.call(int.parse(textController.text)); // no try catch cause block by validator
                      Navigator.of(context).pop();
                    }
                  }, child: const Text("Confirm", style: TextStyle(fontSize: MyDimension.fontDialogButton),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}