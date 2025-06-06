import 'package:nova_task/features/tasks/domain/entities/task.dart';
import 'package:nova_task/features/tasks/domain/repositories/taskRepository.dart';

class GetTasksStatisticsUseCase {
  final TaskRepository repository;

  GetTasksStatisticsUseCase(this.repository);

  Future<Object> execute() => repository.getTasksStatistics();
}
