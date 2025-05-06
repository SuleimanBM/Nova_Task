import "../dataSources/remoteTaskDataSource.dart";
import "../models/task_model.dart";
import "../../domain/repositories/taskRepository.dart";
import "../../domain/entities/task.dart";

class TaskRepositoryImpl implements TaskRepository {
  final RemoteTaskDataSource remote;

  TaskRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async{
    final List<TaskModel> models  = await remote.getTasks();

    return models.map((model) => Task(
      id: model.id,
      title: model.title,
      description: model.description,
      date: model.date,
      //time: model.time,
      priority: model.priority,
      category: model.category,
      status: model.status,
      //subtasks: model.subtasks,
      //isCompleted: model.isCompleted,
    )).toList();
  }
}
