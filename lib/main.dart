import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/view/screens/homescreen.dart';
import 'bloc/task_bloc.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        title: 'Task manager',
        debugShowCheckedModeBanner: false,  
        home: const HomeScreen(),
      ),
    );
  }
}
