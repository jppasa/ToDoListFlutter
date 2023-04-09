import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final ToDo todo;
  final Function(bool?)? onCheckChange;
  final Function()? onEdit;
  final Function()? onDelete;

  const TodoListItem(
    this.todo, {
    Key? key,
    this.onCheckChange,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todo.complete? _completedTodo() : _pendingTodo();
  }

  Widget _completedTodo() {
    return Card(
      color: Colors.white54,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(color: Colors.black12),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          title: Text(
            todo.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          leading: todo.complete
              ? const Icon(Icons.radio_button_checked)
              : const Icon(Icons.radio_button_off),
        ),
      ),
    );
  }

  Widget _pendingTodo(){
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(16),
      //   border: Border.all(color: Colors.black12),
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Dismissible(
          key: Key(todo.id),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              onCheckChange?.call(true);
            }
            return false;
          },
          background: _completeBackground(),
          secondaryBackground: _deleteBackground(),
          child: ListTile(
            title: Text(
              todo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            leading: IconButton(
              onPressed: () {
                onCheckChange?.call(true);
              },
              icon: todo.complete
                  ? const Icon(Icons.radio_button_checked)
                  : const Icon(Icons.radio_button_off),
            ),
            trailing: IconButton(
              iconSize: 24,
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ),
        ),
      ),
    );
  }

  Widget _completeBackground() {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            Text(
              'Complete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _deleteBackground() {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
