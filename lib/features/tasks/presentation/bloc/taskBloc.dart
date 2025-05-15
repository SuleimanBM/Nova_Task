/// lib/presentation/blocs/task_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nova_task/features/tasks/domain/entities/task.dart';
import 'package:nova_task/features/tasks/domain/useCases/addTaskUseCase.dart';
import 'package:nova_task/features/tasks/domain/useCases/deleteTaskUseCase.dart';
import '../../domain/useCases/getTasksStatisticsUseCase.dart';
import './taskEvents.dart';
import './taskState.dart';
import '../../domain/useCases/getAllTaskUseCases.dart';
import "../../domain/useCases/getFilteredTaskUsecase.dart";
import "../../data/models/taskStatistics.dart";

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final GetFilteredTasksUseCase _getFilteredTasksUseCase;
  final GetTasksStatisticsUseCase _getTasksStatisticsUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  TaskBloc(this._getAllTasksUseCase, this._getFilteredTasksUseCase,
      this._getTasksStatisticsUseCase, this._addTaskUseCase, this._deleteTaskUseCase)
      : super(TaskLoading()) {
    // 1. Register handler for LoadTasksEvent
    on<LoadTasks>(_onLoadTasks);
    on<FilterTasks>(_onFilterTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDelteTask);
  }

  // 2. Handler method
  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());

    List<Task> tasks = [];
    TaskStatistics? statistics;
    String? error;

    // Try fetching tasks
    try {
      print("Fetching tasks from backend");
      tasks = await _getAllTasksUseCase.execute();
      print('Fetched tasks: $tasks');
    } catch (e) {
      error = "Failed to load tasks: $e";
    }

    // Try fetching task statistics
    try {
      statistics =
          (await _getTasksStatisticsUseCase.execute()) as TaskStatistics?;
      print('Fetched statistics: $statistics');
    } catch (e) {
      error =
          (error != null ? "$error\n" : "") + "Failed to load statistics: $e";
    }

    // Emit the result
    if (tasks.isNotEmpty || statistics != null) {
      emit(TaskLoaded(tasks, statistics!));
    } else {
      emit(TaskError(error ?? "Unknown error occurred."));
    }
  }

  Future<void> _onFilterTasks(
      FilterTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final filteredTasks = await _getFilteredTasksUseCase.execute(
        status: event.status,
        priority: event.priority,
        category: event.category,
        isCompleted: event.isCompleted,
        date: event.date,
        // You might need to handle date ranges or other complex filters
      );
      final statistics =
          await _getTasksStatisticsUseCase.execute() as TaskStatistics;
      emit(TaskLoaded(filteredTasks, statistics));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading()); // Optional: show loading indicator while adding

    try {
      // Save the task using your use case or repository
      await _addTaskUseCase.execute(event.task);

      // Optionally, you can reload all tasks after adding (if needed)
      final tasks = await _getAllTasksUseCase.execute();
      final statistics =
          await _getTasksStatisticsUseCase.execute() as TaskStatistics;
      if (tasks.isNotEmpty) {
        emit(TaskLoaded(tasks, statistics));
      }
      // Emit updated task list
    } catch (e) {
      emit(TaskError("Failed to add task: ${e.toString()}"));
    }
  }

  Future<void> _onDelteTask(DeleteTask event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      await _deleteTaskUseCase.execute(event.taskId);
      final tasks = await _getAllTasksUseCase.execute();
      final statistics =
          await _getTasksStatisticsUseCase.execute() as TaskStatistics;
      if (tasks.isNotEmpty) {
        emit(TaskLoaded(tasks, statistics));
      }
    } catch (e) {
      emit(TaskError('Failed to delete task'));
    }
  }
}
