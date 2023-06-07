import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/dialog_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback save;
  VoidCallback cancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.save,
    required this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add New Task Here",
              ),
            ),
            // buttons (save + click)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // save button
                MyButton(
                  s: "Save",
                  onPressed: save,
                ),

                SizedBox(
                  width: 20,
                ),
                // cancel button

                MyButton(
                  s: "Cancel",
                  onPressed: cancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
