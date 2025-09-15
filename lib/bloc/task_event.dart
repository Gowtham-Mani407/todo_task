import 'package:equatable/equatable.dart';
import 'package:todo_task/model/taskmodel.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;
  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class ToggleTask extends TaskEvent {
  final String taskId;
  const ToggleTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class DeleteTask extends TaskEvent {
  final String taskId;
  const DeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}


class UpdateTask extends TaskEvent {
  final String taskId;
  final String title;
  final String description;

  UpdateTask({
    required this.taskId,
    required this.title,
    required this.description,
  });
}