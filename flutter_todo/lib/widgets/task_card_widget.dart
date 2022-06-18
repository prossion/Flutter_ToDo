// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:intl/intl.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({Key? key, required this.task, required this.index})
      : super(key: key);
  final TaskModel task;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(task.createdTime);
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
