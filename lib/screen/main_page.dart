import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../components/dialog_box.dart';
import '../components/todo_tasks.dart';
import '../database.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _mybox = Hive.box('myTasks');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_mybox.get("TODOS") == null) {
      db.createInitial();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  // when checbox is tapped

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDos[index][1] = !db.toDos[index][1];
    });
    db.updateList();
  }

  void saveNewTask() {
    setState(() {
      db.toDos.add(
        [_controller.text, false],
      );
      Navigator.of(context).pop();
    });
    _controller.clear();
    db.updateList();
  }

  void cancelTask() {
    setState(() {
      Navigator.of(context).pop();
      _controller.clear();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
            controller: _controller, save: saveNewTask, cancel: cancelTask);
      },
    );
  }

  void deleteTodo(int index) {
    setState(() {
      db.toDos.removeAt(index);
    });
    db.updateList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDos.length,
        itemBuilder: (context, index) {
          return TodoTask(
            taskName: db.toDos[index][0],
            checkTask: db.toDos[index][1],
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
