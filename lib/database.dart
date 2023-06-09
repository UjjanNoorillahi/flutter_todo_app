import 'package:hive_flutter/hive_flutter.dart';

final _mybox = Hive.box('myTasks');

class TodoDatabase {
  List toDos = [];

  void createInitial() {
    toDos = [
      ["Work", false],
      ["Eat", false]
    ];
  }

  void loadData() {
    toDos = _mybox.get("TODOS");
  }

  void updateList() {
    _mybox.put("TODOS", toDos);
  }
}
