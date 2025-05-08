import 'package:equatable/equatable.dart';
import 'package:nova_task/features/tasks/domain/entities/task.dart';

class TaskStatistics {
  final int completed;
  final int pending;
  final int overdue;

  const TaskStatistics({
    required this.completed,
    required this.pending,
    required this.overdue,
  });
}

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final TaskStatistics? tasksStatistics;
  TaskLoaded(this.tasks, [this.tasksStatistics]);
  @override
  List<Object?> get props => [tasksStatistics, tasks];
}

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
  @override
  List<Object?> get props => [message];
}
