import 'package:nova_task/features/tasks/domain/entities/task.dart';
import 'package:nova_task/features/tasks/domain/repositories/taskRepository.dart';

class GetTasksStatisticsUsecase {
  final TaskRepository repository;

  GetTasksStatisticsUsecase(this.repository);

  Future<Object> execute() => repository.getTasksStatistics();
}
