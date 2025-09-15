import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_task/bloc/task_bloc.dart';
import 'package:todo_task/bloc/task_event.dart';
import 'package:todo_task/model/taskmodel.dart';
import 'package:todo_task/view/screens/homescreen.dart';

void main() {
  testWidgets("Add task and display in list", (WidgetTester tester) async {
    final taskBloc = TaskBloc();

    await tester.pumpWidget(
      BlocProvider.value(
        value: taskBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    taskBloc.add(
      AddTask(
        Task(
          id: "1",
          title: "Gowtham today should buy groceries",
          description: "Milk, eggs, and bread",
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Gowtham today should buy groceries"), findsOneWidget);
    expect(find.text("Milk, eggs, and bread"), findsOneWidget);

    expect(find.text("No tasks yet , add some!"), findsNothing);
  });
}
