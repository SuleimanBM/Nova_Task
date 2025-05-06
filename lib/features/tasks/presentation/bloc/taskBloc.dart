/// lib/presentation/blocs/task_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import './taskEvents.dart';
import './taskState.dart';
import '../../domain/useCases/getAllTaskUseCases.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTasksUsecase _getTasksUseCase;

  TaskBloc(this._getTasksUseCase) : super(TaskLoading()) {
    // 1. Register handler for LoadTasksEvent
    on<LoadTasks>(_onLoadTasks);
  }

  // 2. Handler method
  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final tasks = await _getTasksUseCase.execute();
      print('Fetched tasks: ${tasks.length}');
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
