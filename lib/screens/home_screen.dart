import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
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

  List<Task> _tasks = [];

// lets write addTask Method;
  @override
  void initState() {
    super.initState();

    callFirst();
  }

  Future<void> callFirst() async {
    _tasks = await SharedPrefService.getTodoFromLocalStorage();
    setState(() {});
    print({"todo inside storage ", _tasks});
  }

  void _addTask() {
    if (_textConroller.text.isNotEmpty) {
      setState(() {
        _tasks.add(
            Task(id: Uuid().v4(), title: _textConroller.text, isDone: false));
        SharedPrefService.saveTodoInLocalStorage(_tasks);

        _textConroller.clear();
      });
    }
    String csv = _tasks.join(',');
    print(csv);
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);

      _textConroller.clear();
    });
  }

  void _editTask(index) {
    setState(() {
      _index = index;
      isEditing = true;
      _textConroller.text = _tasks[index].title;
    });
  }

  void _saveTodo() {
    setState(() {
      _tasks[_index].title = _textConroller.text;
      SharedPrefService.saveTodoInLocalStorage(_tasks);
      isEditing = false;
      _textConroller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        Positioned.fill(
          child: Image.asset(
            'assets/images/b.jpeg', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: _textConroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))))),
                  () {
                    if (isEditing) {
                      return IconButton(
                        onPressed: () => _saveTodo(),
                        icon: const Icon(Icons.save),
                        color: Colors.green[300],
                        iconSize: 20,
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: IconButton(
                        onPressed: _addTask,
                        icon: const Icon(Icons.add),
                        color: Colors.orange[300],
                        iconSize: 30,
                      ),
                    );
                  }(),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.blue,
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) => Row(children: [
                  Expanded(
                      child: ListTile(
                    title: Text(_tasks[index].title),
                  )),
                  Expanded(
                      child: IconButton(
                          onPressed: () => _removeTask(index),
                          icon: const Icon(Icons.delete))),
                  Expanded(
                      child: IconButton(
                          onPressed: () => _editTask(index),
                          icon: const Icon(Icons.edit)))
                ]),
              ),
            ))
          ],
        ),
      ]),
    );
  }
}
