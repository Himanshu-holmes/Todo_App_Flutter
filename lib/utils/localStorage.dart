import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task.dart';

class SharedPrefService {
  static const String todoListKey = "todo_list";

  // Get todo from local storage
  static Future<List<Task>> getTodoFromLocalStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? encodedTodos = pref.getString(todoListKey);
    if (encodedTodos == null) {
      return [];
    }
    final List<dynamic> decodedTodos = jsonDecode(encodedTodos) as List<dynamic>;

    return decodedTodos
        .map((todo) => Task(
            id: todo['id'] as String,
            title: todo['title'] as String,
            isDone: todo['isDone'] as bool))
        .toList();
  }

  // Save todo to local storage
  static Future<void> saveTodoInLocalStorage(List<Task> todos) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> encodedTodos = todos
        .map((todo) => {"id": todo.id, "title": todo.title, "isDone": todo.isDone})
        .toList();

    final String encodeJsonTodo = jsonEncode(encodedTodos);

    pref.setString(todoListKey, encodeJsonTodo);
  }
}