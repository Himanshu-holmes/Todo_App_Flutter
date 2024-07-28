import 'package:flutter/foundation.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/localStorage.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  int _index = -1;
  var _textTitle;
  bool isEditing = false;
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
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    SharedPrefService.saveTodoInLocalStorage(_tasks);
    notifyListeners();
  }

  void editTask(index, textFromController) {
    if (index < 0) {
      return;
    }

    _index = index;
    isEditing = true;
    _textTitle = textFromController;
    // _textConroller.text = _tasks[index].title;
  }

  void saveTodo() {
    tasks[_index].title = _textTitle;
    SharedPrefService.saveTodoInLocalStorage(_tasks);
    isEditing = false;
  }
}
