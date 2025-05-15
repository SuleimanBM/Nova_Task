import 'package:equatable/equatable.dart';
import 'package:nova_task/features/tasks/domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {}

class FilterTasks extends TaskEvent {
   final String? status;
  final String? priority;
  final String? category;
  final bool? isCompleted;
  final DateTime? date; // For date-specific filtering

  FilterTasks({
    this.status,
    this.priority,
    this.category,
    this.isCompleted,
    this.date,
  });

  @override
  List<Object?> get props => [status, priority, category, isCompleted, date];
}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;
  DeleteTask(this.taskId);
  @override
  List<Object> get props => [taskId];
}
