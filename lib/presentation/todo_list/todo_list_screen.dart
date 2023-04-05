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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
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
          return _todoItem(todos[index]);
        });
  }

  Widget _todoItem(ToDo todo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        leading: Checkbox(
          value: false,
          onChanged: (value) {
            print(value);
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              iconSize: 24,
              icon: const Icon(Icons.edit),
              onPressed: () {
                print("hola");
              },
            ),
            IconButton(
              iconSize: 24,
              icon: const Icon(Icons.delete),
              onPressed: () {
                print("hola");
              },
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
