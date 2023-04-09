import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/todo.dart';
import 'todo_list_item.dart';
import 'todo_list_state.dart';
import 'todo_list_view_model.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ToDoListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My ToDos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateOrEditToDoAlert(
            context,
            onActionPressed: (text) {
              viewModel.addTodo(text);
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
      body: body(viewModel),
    );
  }

  Widget body(ToDoListViewModel viewModel) {
    var state = viewModel.state;

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
        return _buildToDoList(viewModel, (state as ToDoListSuccessState).list);
      default:
        return const SizedBox();
    }
  }

  Widget _buildToDoList(ToDoListViewModel viewModel, List<ToDo> todos) {
    if (todos.isEmpty) {
      return const Center(
        child: Text("No ToDos yet"),
      );
    }

    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];
          return TodoListItem(
            todo,
            onCheckChange: (value) =>
                viewModel.toggleCompleted(todo, value ?? false),
            onEdit: () {
              _showCreateOrEditToDoAlert(
                context,
                todo: todo,
                onActionPressed: (newText) {
                  viewModel.editTodoTitle(todo, newText);
                },
              );
            },
            onDelete: () {},
          );
        });
  }

  Future<void> _showCreateOrEditToDoAlert(BuildContext context,
      {ToDo? todo, Function(String)? onActionPressed}) {
    var isEdit = todo != null;
    var textEditingController = TextEditingController(text: todo?.title);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(isEdit ? 'Edit' : 'Add a ToDo'),
            content: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  hintText: "What is there to accomplish?"),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  onActionPressed?.call(textEditingController.text);
                  Navigator.pop(context);
                },
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Text(isEdit? 'Edit' : 'Add'),
              )
            ],
          );
        });
  }
}
