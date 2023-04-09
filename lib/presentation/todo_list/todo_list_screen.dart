import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/todo.dart';
import 'todo_list_item.dart';
import 'todo_list_state.dart';
import 'todo_list_view_model.dart';

class TodoListScreen extends StatelessWidget {
  TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ToDoListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddToDoAlert(
            context,
            addTodo: (text) {
              viewModel.addTodo(text);
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
      body: body(viewModel.state),
    );
  }

  Widget body(ToDoListState state) {
    switch (state.runtimeType) {
      case ToDoListLoadingState:
        return const Center(child: CircularProgressIndicator());
      case ToDoListErrorState:
        return Center(
          child: Column(
            children: const [Icon(Icons.error), Text("Error fetching data.")],
          ),
        );
      case ToDoListSuccessState:
        return _buildToDoList((state as ToDoListSuccessState).list);
      default:
        return const SizedBox();
    }
  }

  Widget _buildToDoList(List<ToDo> todos) {
    if (todos.isEmpty) {
      return const Center(
        child: Text("No ToDos yet"),
      );
    }
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoListItem(todos[index]);
        });
  }

  Future<void> _showAddToDoAlert(BuildContext context,
      {required Function(String) addTodo}) {
    var textEditingController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a ToDo'),
            content: TextField(
              onChanged: (value) {},
              controller: textEditingController,
              decoration: const InputDecoration(
                  hintText: "What is there to accomplish?"),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  addTodo(textEditingController.text);
                  Navigator.pop(context);
                },
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: const Text('Add'),
              )
            ],
          );
        });
  }
}
