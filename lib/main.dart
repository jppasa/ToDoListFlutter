import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/di/locator.dart';
import 'config/router/router.dart';
import 'domain/feature/todo_list/add_todo_use_case.dart';
import 'domain/feature/todo_list/get_todo_list_use_case.dart';
import 'domain/feature/todo_list/sync_todos.dart';
import 'domain/feature/todo_list/toggle_todo_completion_use_case.dart';
import 'domain/repositories/api_repository.dart';
import 'domain/repositories/db_repository.dart';
import 'presentation/todo_list/todo_list_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ToDoListViewModel(
              GetToDoListUseCase(
                locator<DbRepository>(),
              ),
              FetchTodosUseCase(
                locator<ApiRepository>(),
                locator<DbRepository>(),
              ),
              AddToDoListUseCase(
                locator<ApiRepository>(),
                locator<DbRepository>(),
              ),
              ToggleTodoCompletionUseCase(
                locator<ApiRepository>(),
                locator<DbRepository>(),
              ),
            ),
        child: Consumer<ToDoListViewModel>(
          builder: (context, model, child) {
            return MaterialApp.router(
              routerConfig: appRouter,
            );
          },
        ));

    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => ToDoListCubit(
    //         locator<ApiRepository>(),
    //       )..getToDoList(),
    //     )
    //   ],
    //   child: MaterialApp.router(
    //     //routerDelegate: appRouter.routerDelegate,
    //     routerConfig: appRouter,
    //   ),
    // );
  }
}
