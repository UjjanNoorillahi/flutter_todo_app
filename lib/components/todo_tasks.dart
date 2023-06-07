import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTask extends StatelessWidget {
  final String taskName;
  final bool checkTask;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;
  TodoTask(
      {super.key,
      required this.taskName,
      required this.checkTask,
      required this.onChanged,
      required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTask,
            icon: Icons.remove,
            backgroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(15),
          )
        ]),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.amber[100],
          ),
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Checkbox(
                value: checkTask,
                onChanged: onChanged,
                activeColor: checkTask ? Colors.green : Colors.red,
              ),
              Text(
                taskName,
                style: TextStyle(
                    fontSize: 20,
                    decoration: checkTask
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
