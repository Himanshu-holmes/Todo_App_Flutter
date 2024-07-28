import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/utils/localStorage.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your logic to handle the task addition here

                  String taskTitle = _textController.text;
                  var task =
                      Task(id: Uuid().v4(), title: taskTitle, isDone: false);
                  value.addTask(task);
                  _textController.clear();
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
