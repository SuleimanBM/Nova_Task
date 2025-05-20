import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:nova_task/features/tasks/data/models/taskModel.dart';
import 'package:nova_task/features/tasks/domain/useCases/addTaskUseCase.dart';
import 'package:nova_task/features/tasks/domain/useCases/deleteTaskUseCase.dart';
import 'package:nova_task/features/tasks/domain/useCases/getFilteredTaskUsecase.dart';
import 'package:nova_task/features/tasks/domain/useCases/getTasksStatisticsUseCase.dart';
import 'package:nova_task/features/tasks/presentation/widgets/taskCard.dart';
import 'package:nova_task/features/users/data/datasources/remoteUserDataSource.dart';
import 'package:nova_task/features/users/data/repositories/authRepositoryImpl.dart';
import 'package:nova_task/features/users/domain/repositories/authRepository.dart';
import 'package:nova_task/features/users/domain/useCases/loginUseCase.dart';
import 'package:nova_task/features/users/domain/useCases/signupUseCase.dart';
import 'package:nova_task/features/users/presentation/bloc/authBloc.dart';

import './tasks/data/dataSources/remoteTaskDataSource.dart';
import './tasks/domain/repositories/taskRepository.dart';
import './tasks/data/repositories/taskRepositoryImpl.dart';
import 'tasks/domain/useCases/getAllTaskUseCases.dart';
import "./tasks/presentation/bloc/taskBloc.dart";
// import 'presentation/blocs/task_bloc.dart';

final sl = GetIt.instance;
Future<void> initDependencies() async {
  try {
    // 1. External dependencies (SYNC)
    sl.registerLazySingleton<http.Client>(() => http.Client());

    // 7. Auth dependencies
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(sl<http.Client>()),
    );

    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
    );

    sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(sl<AuthRepository>()),
    );

    sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    );

    sl.registerLazySingleton<AuthBloc>(
      () => AuthBloc(sl<LoginUseCase>(), sl<SignUpUseCase>()),
    );

    // 2. Data sources (ASYNC)
    sl.registerSingletonAsync<RemoteTaskDataSource>(
      () async => RemoteTaskDataSource.create(sl<http.Client>()),
    );

    // 3. Wait for async data sources to initialize
    await sl.isReady<RemoteTaskDataSource>();

    // 4. Repository implementation (SYNC)
    sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(sl<RemoteTaskDataSource>()),
    );

    // 5. Use cases (SYNC)
    sl.registerLazySingleton<GetAllTasksUseCase>(
      () => GetAllTasksUseCase(sl<TaskRepository>()),
    );
    sl.registerLazySingleton<GetFilteredTasksUseCase>(
      () => GetFilteredTasksUseCase(sl<TaskRepository>()),
    );
    sl.registerLazySingleton<GetTasksStatisticsUseCase>(
      () => GetTasksStatisticsUseCase(sl<TaskRepository>()),
    );
    sl.registerLazySingleton<AddTaskUseCase>(
      () => AddTaskUseCase(sl<TaskRepository>()),
    );
    sl.registerLazySingleton<DeleteTaskUseCase>(
      () => DeleteTaskUseCase(sl<TaskRepository>()),
    );

    // 6. Blocs (FACTORY)
    sl.registerFactory<TaskBloc>(
      () => TaskBloc(
        sl<GetAllTasksUseCase>(),
        sl<GetFilteredTasksUseCase>(),
        sl<GetTasksStatisticsUseCase>(),
        sl<AddTaskUseCase>(),
        sl<DeleteTaskUseCase>(),
      ),
    );

    
  } catch (e) {
    throw Exception('DI initialization failed: $e');
  }
}
