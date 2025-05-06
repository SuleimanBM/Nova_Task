import 'package:nova_task/features/tasks/domain/entities/task.dart';
import 'package:nova_task/features/tasks/domain/repositories/taskRepository.dart';

class GetAllTasksUsecase {
  final TaskRepository repository;

  GetAllTasksUsecase(this.repository);

  Future<List<Task>> execute() => repository.getTasks();

}