import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/utils/localStorage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  // bool isEditing = false;

// lets write addTask Method;
  @override
  void initState() {
    super.initState();

    callFirst();
  }

  Future<void> callFirst() async {
    var tasks = await SharedPrefService.getTodoFromLocalStorage();
    Provider.of<TaskProvider>(context, listen: false).setTask(tasks);
    setState(() {});
    print({"todo inside storage ", tasks});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
        builder: ((context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text("TODO List"),
              backgroundColor: const Color.fromARGB(255, 255, 176, 7),
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2),
            ),
            body: Stack(children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.blue,
                    child: ListView.builder(
                      itemCount: value.tasks.length,
                      itemBuilder: (context, index) => Row(children: [
                        Expanded(
                            child: ListTile(
                          title: Text(value.tasks[index].title),
                        )),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  value.removeTask(index);
                                }, //_removeTask(index),
                                icon: const Icon(Icons.delete))),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  value.editTask(index, _textController.text);
                                  _editTask(context, index, value.tasks[index]);
                                },
                                icon: const Icon(Icons.edit)))
                      ]),
                    ),
                  )),
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/add_task");
                      },
                      child: const Icon(Icons.add))
                ],
              ),
            ]))));
  }

  void _editTask(BuildContext context, int index, Task task) {
    _textController.text = task.title;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Task"),
        content: TextField(
          controller: _textController,
          decoration: InputDecoration(hintText: "Task Title"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).saveTodo();
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
