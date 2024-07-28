import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => TaskProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(197, 91, 239, 11)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        routes: {"/add_task": (context) => AddTaskScreen()},
      ),
    );
  }
}
