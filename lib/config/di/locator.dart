import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/remote/api_repository_impl.dart';
import '../../data/datasources/remote/todo_service.dart';
import '../../domain/repositories/api_repository.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<ToDoService>(
    ToDoService(locator<Dio>()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ToDoService>()),
  );
}