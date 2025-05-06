import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './tasks/data/dataSources/remoteTaskDataSource.dart';
import './tasks/domain/repositories/taskRepository.dart';
import './tasks/data/repositories/taskRepositoryImpl.dart';
import 'tasks/domain/useCases/getAllTaskUseCases.dart';
import "./tasks/presentation/bloc/taskBloc.dart";
// import 'presentation/blocs/task_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  try {
     // 1. External dependencies
    sl.registerLazySingleton<http.Client>(() =>
        http.Client()); // HTTP client :contentReference[oaicite:11]{index=11}

    // 2. Data sources
    sl.registerLazySingleton<RemoteTaskDataSource>(
      // Register data source
      () => RemoteTaskDataSource(sl<
          http
          .Client>()), // Inject HTTP client :contentReference[oaicite:12]{index=12}
    );

    // 3. Repository implementation
    sl.registerLazySingleton<TaskRepository>(
      // Bind interface
      () => TaskRepositoryImpl(
          sl()), // Inject data source :contentReference[oaicite:13]{index=13}
    );

    // 4. Use case
    sl.registerLazySingleton<GetAllTasksUsecase>(
      // Register use case
      () => GetAllTasksUsecase(
          sl()), // Inject repository :contentReference[oaicite:14]{index=14}
    );

    sl.registerFactory<TaskBloc>(
      // Register Bloc
      () => TaskBloc(
          sl()), // Inject use case :contentReference[oaicite:15]{index=15}
    );
  } catch (e) {
    throw Exception('DI initialization failed: $e');
  }
 
}
