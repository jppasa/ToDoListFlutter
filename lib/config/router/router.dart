import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => HomeScreen())
]);