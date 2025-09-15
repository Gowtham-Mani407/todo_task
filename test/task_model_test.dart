import 'package:flutter_test/flutter_test.dart';
import 'package:todo_task/model/taskmodel.dart';

void main() {
  test("Task copyWith should update fields", () {
    const task = Task(id: "1", title: "Test", description: "Desc");
    final updated = task.copyWith(isCompleted: true);

    expect(updated.isCompleted, true);
    expect(updated.title, "Test");
  });
}
