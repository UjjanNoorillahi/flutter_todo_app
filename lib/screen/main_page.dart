import 'package:flutter/material.dart';

import '../components/dialog_box.dart';
import '../components/todo_tasks.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = TextEditingController();

  List toDos = [
    ["Exercise", false],
    ["Eat Food", false]
  ];

  // when checbox is tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDos[index][1] = !toDos[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDos.add(
        [_controller.text, false],
      );
      Navigator.of(context).pop();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          save: saveNewTask,
          cancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTodo(int index) {
    setState(() {
      toDos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (context, index) {
          return TodoTask(
            taskName: toDos[index][0],
            checkTask: toDos[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            deleteTask: (context) => deleteTodo(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
