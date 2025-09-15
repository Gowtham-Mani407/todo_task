import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/model/taskmodel.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>((event, emit) {
      // final updated = List<Task>.from(state.tasks);
      // updated.add(event.task);
      List<Task>? updated = List.from(state.tasks)..add(event.task);
      emit(state.copyWith(tasks: updated));
    });

    on<ToggleTask>((event, emit) {
      final updated = state.tasks.map((task) {
        return task.id == event.taskId
            ? task.copyWith(isCompleted: !task.isCompleted)
            : task;
      }).toList();
      emit(state.copyWith(tasks: updated));
    });

    on<DeleteTask>((event, emit) {
      final updated = state.tasks
          .where((item) => item.id != event.taskId)
          .toList();
      emit(state.copyWith(tasks: updated));
    });

    on<UpdateTask>((event, emit) {
      final updated = state.tasks.map((task) {
        if (task.id == event.taskId) {
          return task.copyWith(
            title: event.title,
            description: event.description,
          );
        }
        return task;
      }).toList();
      emit(state.copyWith(tasks: updated));
    });
  }
}
