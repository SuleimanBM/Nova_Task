import 'package:nova_task/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();

  Future<List<Task>> getFilteredTasks({
    String? status,
    String? priority,
    String? category,
    bool? isCompleted,
    DateTime? date, // Add this line
  });

  Future<Object> getTasksStatistics();

  // Future<void> addTask(Task task);

  // Future<void> deleteTask(Task task);

  // Future<void> updateTask(Task task);

  // Future<void> completeTask(Task task);
}
