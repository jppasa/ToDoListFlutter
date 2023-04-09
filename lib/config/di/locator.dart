import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/local/app_db.dart';
import '../../data/remote/todo_service.dart';
import '../../data/repository/DbRepositoryImpl.dart';
import '../../data/repository/api_repository_impl.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/repositories/db_repository.dart';
import '../../utils/constants.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  final database = await $FloorAppDb.databaseBuilder(appDbName).build();

  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<AppDb>(database);

  locator.registerSingleton<DbRepository>(
    DbRepositoryImpl(locator<AppDb>()),
  );

  locator.registerSingleton<ToDoService>(
    ToDoService(locator<Dio>()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ToDoService>()),
  );
}
