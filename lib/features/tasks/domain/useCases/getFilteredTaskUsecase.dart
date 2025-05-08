import 'package:nova_task/features/tasks/domain/entities/task.dart';
import 'package:nova_task/features/tasks/domain/repositories/taskRepository.dart';

class GetFilteredTaskUsecase {
  final TaskRepository repository;

  GetFilteredTaskUsecase(this.repository);

  Future<List<Task>> execute({
    String? status,
    String? priority,
    String? category,
    bool? isCompleted,
    DateTime? date,
  }) => repository.getFilteredTasks(
        status: status,
        priority: priority,
        category: category,
        isCompleted: isCompleted,
        date: date,
      );
}
