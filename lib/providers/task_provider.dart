import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/localStorage.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks {
    return [..._tasks];
  }

  void setTask(tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  // void addTask(Task task) {
  //   tasks.add(task);
  //   notifyListeners();
  // }

  void addTask(task) {
    _tasks.add(task);
    SharedPrefService.saveTodoInLocalStorage(_tasks);

    notifyListeners();

    String csv = _tasks.join(',');
    print(csv);
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    SharedPrefService.saveTodoInLocalStorage(_tasks);
    notifyListeners();
  }

  // void _editTask(index) {
  //   setState(() {
  //     _index = index;
  //     isEditing = true;
  //     _textConroller.text = _tasks[index].title;
  //   });
  // }

  // void _saveTodo() {
  //   setState(() {
  //     tasks[_index].title = _textConroller.text;
  //     SharedPrefService.saveTodoInLocalStorage(_tasks);
  //     isEditing = false;
  //     _textConroller.clear();
  //   });
  // }
}
