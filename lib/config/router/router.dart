import 'package:go_router/go_router.dart';

import '../../presentation/todo_list/todo_list_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const TodoListScreen()),
]);
