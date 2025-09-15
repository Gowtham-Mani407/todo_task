import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_task/bloc/task_bloc.dart';
import 'package:todo_task/bloc/task_event.dart';
import 'package:todo_task/model/taskmodel.dart';
import 'package:todo_task/view/screens/homescreen.dart';

void main() {
  testWidgets("Add task and display in list", (WidgetTester tester) async {
    // 1. Render HomeScreen inside a BlocProvider
    final taskBloc = TaskBloc();

    await tester.pumpWidget(
      BlocProvider.value(
        value: taskBloc,
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    // 2. Dispatch event to add dummy task
    taskBloc.add(
      AddTask(
        Task(
          id: "1",
          title: "Gowtham today should buy groceries",
          description: "Milk, eggs, and bread",
        ),
      ),
    );

    // 3. Pump to let UI rebuild with new state
    await tester.pumpAndSettle();

    // 4. Verify the new task is displayed
    expect(find.text("Gowtham today should buy groceries"), findsOneWidget);
    expect(find.text("Milk, eggs, and bread"), findsOneWidget);

    // (Optional) verify that "No tasks yet" message is gone
    expect(find.text("No tasks yet , add some!"), findsNothing);
  });
}
