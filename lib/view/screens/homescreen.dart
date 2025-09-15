import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc.dart';
import 'package:todo_task/bloc/task_event.dart';
import 'package:todo_task/bloc/task_state.dart';
import 'package:todo_task/model/taskmodel.dart';
import 'package:todo_task/view/widgets/addtaskdialog.dart';
import 'package:todo_task/view/widgets/custom_row.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    void addTask() {
      if (titleController.text.isNotEmpty) {
        context.read<TaskBloc>().add(
          AddTask(
            Task(
              id: const Uuid().v4(),
              title: titleController.text,
              description: descController.text,
            ),
          ),
        );
        titleController.clear();
        descController.clear();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Title cannot be empty")));
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Task Mananger")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.tasks.isEmpty) {
            return const Center(child: Text("No tasks yet , add some!"));
          }
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              return CustomCard(task: state.tasks[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
            context: context,
            barrierColor: Colors.black54, 
            builder: (_) => AddTaskDialog(
              titleController: titleController,
              descController: descController,
              onAdd: addTask,
            ),
          );
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
