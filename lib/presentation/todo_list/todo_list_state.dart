import 'package:dio/dio.dart';

import '../../domain/models/todo.dart';

abstract class ToDoListState {
  const ToDoListState();

  factory ToDoListState.loading() = ToDoListLoadingState;
  factory ToDoListState.success(List<ToDo> list) = ToDoListSuccessState;
  factory ToDoListState.error(DioError error) = ToDoListErrorState;
}

class ToDoListLoadingState extends ToDoListState {
  const ToDoListLoadingState(): super();
}

class ToDoListSuccessState extends ToDoListState {
  final List<ToDo> list;
  const ToDoListSuccessState(this.list): super();
}

class ToDoListErrorState extends ToDoListState {
  final DioError error;
  const ToDoListErrorState(this.error): super();
}