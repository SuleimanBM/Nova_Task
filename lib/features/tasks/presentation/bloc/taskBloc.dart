/// lib/presentation/blocs/task_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/useCases/getTasksStatisticsUseCase.dart';
import './taskEvents.dart';
import './taskState.dart';
import '../../domain/useCases/getAllTaskUseCases.dart';
import "../../domain/useCases/getFilteredTaskUsecase.dart";
import "../../data/models/taskStatistics.dart";

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUsecase _getTasksUseCase;
  final GetFilteredTaskUsecase _getFilteredTasksUseCase;
  final GetTasksStatisticsUsecase _getTasksStatisticsUseCase;

  TaskBloc(this._getTasksUseCase, this._getFilteredTasksUseCase,
      this._getTasksStatisticsUseCase)
      : super(TaskLoading()) {
    // 1. Register handler for LoadTasksEvent
    on<LoadTasks>(_onLoadTasks);
    on<FilterTasks>(_onFilterTasks);
  }

  // 2. Handler method
  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      print("Fetching task from backend");
      final tasks = await _getTasksUseCase.execute();
      final tasksStatistics = await _getTasksStatisticsUseCase.execute();
      print('Fetched tasks: ${tasks}');
      print(tasksStatistics);
      emit(TaskLoaded(tasks, tasksStatistics as TaskStatistics?));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  // Future<void> _onFilterTasks(
  //   FilterTasks event,
  //   Emitter<TaskState> emit,
  // ) async {
  //   emit(TaskLoading());
  //   try {
  //     final tasks = await _getFilteredTasksUseCase.execute(event.filter);
  //     print('Fetched tasks: ${tasks.length}');
  //     emit(TaskLoaded(tasks));
  //   } catch (e) {
  //     emit(TaskError(e.toString()));
  //   }
  // }

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
      emit(TaskLoaded(filteredTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
