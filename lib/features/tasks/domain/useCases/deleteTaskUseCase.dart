import 'package:nova_task/features/tasks/domain/repositories/taskRepository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<void> execute (String taskId) async {
    return await repository.deleteTask(taskId);
  }
}
