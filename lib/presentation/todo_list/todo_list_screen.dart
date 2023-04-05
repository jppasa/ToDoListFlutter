import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/cubits/todo_list_cubit.dart';
import '../../domain/models/todo.dart';
import 'todo_list_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDos'),
      ),
      body: BlocBuilder<ToDoListCubit, ToDoListState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case ToDoListLoadingState:
              return const Center(child: CircularProgressIndicator());
            case ToDoListErrorState:
              return Center(
                child: Column(
                  children: const [
                    Icon(Icons.error),
                    Text("Error fetching data.")
                  ],
                ),
              );
            case ToDoListSuccessState:
              return _buildToDoList((state as ToDoListSuccessState).list);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildToDoList(List<ToDo> todos) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todos[index].title),
            ),
          );
        });
  }
}
