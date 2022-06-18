// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_todo/db/tasks_database.dart';
import 'package:flutter_todo/model/task_model.dart';
import 'package:flutter_todo/screens/add_edit_task_page.dart';
import 'package:flutter_todo/screens/task_detail_page.dart';
import 'package:flutter_todo/widgets/task_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<TaskModel> tasks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTasks();
  }

  @override
  void dispose() {
    TasksDatabase.instance.close();
    super.dispose();
  }

  void refreshTasks() async {
    setState(() => isLoading = true);

    tasks = await TasksDatabase.instance.readAllTasks();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo', style: TextStyle(fontSize: 24)),
        // actions: const [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : tasks.isEmpty
                ? const Text(
                    'No Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetailPage(taskId: task.id!),
                            ),
                          );
                          refreshTasks();
                        },
                        child: TaskCardWidget(
                          task: task,
                          index: index,
                        ),
                      );
                    },
                    itemCount: tasks.length,
                  ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditTaskPage()),
            );
            refreshTasks();
          }),
    );
  }
}
