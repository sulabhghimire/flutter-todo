import 'package:flutter/material.dart';
import 'package:todo/widgets/add_todo.dart';
import 'package:todo/widgets/todo_list.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = 'ToDos';
    return MaterialApp(
      title: title,
      theme: ThemeData(useMaterial3: true),
      home: const ToDoList(title: title),
    );
  }
}
