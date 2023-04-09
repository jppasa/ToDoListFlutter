import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/feature/todo_list/add_todo_use_case.dart';
import '../../domain/feature/todo_list/get_todo_list_use_case.dart';
import '../../domain/feature/todo_list/sync_todos.dart';
import '../../domain/feature/todo_list/toggle_todo_completion_use_case.dart';
import '../../domain/models/todo.dart';
import 'todo_list_state.dart';

class ToDoListViewModel extends ChangeNotifier {
  final GetToDoListUseCase _getToDoListUseCase;
  final FetchTodosUseCase _fetchTodosUseCase;
  final AddToDoListUseCase _addTodoUseCase;
  final ToggleTodoCompletionUseCase _todoCompletionUseCase;

  ToDoListState state = ToDoListState.loading();

  ToDoListViewModel(
    this._getToDoListUseCase,
    this._fetchTodosUseCase,
    this._addTodoUseCase,
    this._todoCompletionUseCase,
  ) {
    init();
  }

  void init() async {
    _getToDoListUseCase.getToDoListLocally().listen((list) {
      state = ToDoListState.success(list);
      notifyListeners();
    });

    _fetchTodosUseCase.getToDoListFromRemote();
  }

  Future<void> addTodo(String text) async {
    var result = await _addTodoUseCase.addTodoFromTextAndSync(text);
    // TODO show toast with error, maybe use Bloc?
    // This could mean changing Provider/ChangeNotifier to all Block/Cubits pattern
  }

  void toggleCompleted(ToDo todo, bool completed) {
    _todoCompletionUseCase.toggleCompletion(todo, completed);
  }
}
