import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/utils/localStorage.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  bool isEditing = false;

  final TextEditingController _textConroller = TextEditingController();

  // final tasks = Provider.of<TaskProvider>(listen: ).tasks;

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
                                onPressed: () {}, //_editTask(index),
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
}
