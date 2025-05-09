import "../dataSources/remoteTaskDataSource.dart";
import "../models/taskModel.dart";
import "../../domain/repositories/taskRepository.dart";
import "../../domain/entities/task.dart";

class TaskRepositoryImpl implements TaskRepository {
  final RemoteTaskDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async {
     print("💡 Repository: calling remote.getTasks()");
    final List<TaskModel> models = await remote.getTasks();
print("💡 Repository: remote returned ${models.length} models");
    return models
        .map((model) => Task(
              id: model.id,
              title: model.title,
              description: model.description,
              date: model.date,
              time: model.time,
              priority: model.priority,
              category: model.category,
              subtasks: model.subtasks,
              isCompleted: model.isCompleted,
            ))
        .toList();
  }

  Future<List<Task>> getFilteredTasks({
    String? status,
    String? priority,
    String? category,
    bool? isCompleted,
    DateTime? date, // Add this line
  }) async {
    final List<TaskModel> models = await remote.getFilteredTasks(
      status: status,
      priority: priority,
      category: category,
      isCompleted: isCompleted,
      date: date,
    );

    return models.map((model) => Task(
      id: model.id,
              title: model.title,
              description: model.description,
              date: model.date,
              time: model.time,
              priority: model.priority,
              category: model.category,
              subtasks: model.subtasks,
              isCompleted: model.isCompleted,
    )).toList();
  }

  Future<Object> getTasksStatistics() async {
    final response = await remote.getTasksStatistics();
    return response;
  }
}

