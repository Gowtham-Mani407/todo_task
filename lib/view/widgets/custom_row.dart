import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/bloc/task_bloc.dart';
import 'package:todo_task/bloc/task_event.dart';
import 'package:todo_task/model/taskmodel.dart';

class CustomCard extends StatelessWidget {
  final Task task;
  const CustomCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) {
                context.read<TaskBloc>().add(ToggleTask(task.id));
              },
            ),
            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: task.isCompleted ? Colors.grey : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: task.isCompleted
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    "Status : ${task.isCompleted ? "Completed" : "Pending"}",
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: task.isCompleted
                          ? Colors.green
                          : Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(
                Icons.delete_forever_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Delete Task"),
                    content: const Text(
                      "Are you sure you want to delete this task?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(), 
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<TaskBloc>().add(DeleteTask(task.id));
                          Navigator.of(ctx).pop(); 
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
