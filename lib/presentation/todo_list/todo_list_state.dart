import 'package:dio/dio.dart';

import '../../domain/models/todo.dart';

abstract class ToDoListState {
  ToDoListState._();

  factory ToDoListState.loading() = ToDoListLoadingState;
  factory ToDoListState.success(List<ToDo> list) = ToDoListSuccessState;
  factory ToDoListState.error(DioError error) = ToDoListErrorState;
}

class ToDoListLoadingState extends ToDoListState {
  ToDoListLoadingState(): super._();
}

class ToDoListSuccessState extends ToDoListState {
  final List<ToDo> list;
  ToDoListSuccessState(this.list): super._();
}

class ToDoListErrorState extends ToDoListState {
  final DioError error;
  ToDoListErrorState(this.error): super._();
}