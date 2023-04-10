import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final ToDo todo;
  final Function(bool? completed)? onComplete;
  final Function()? onEdit;
  final Function()? onDelete;

  const TodoListItem(
    this.todo, {
    Key? key,
    this.onComplete,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todo.complete ? _completedTodo() : _pendingTodo();
  }

  Widget _completedTodo() {
    return Card(
      color: Colors.white54,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          title: Text(
            todo.title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                color: Colors.black54),
          ),
          leading: const Icon(Icons.check_circle),
        ),
      ),
    );
  }

  Widget _pendingTodo() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Dismissible(
          key: UniqueKey(),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              onDelete?.call();
            } else if (direction == DismissDirection.startToEnd) {
              onComplete?.call(true);
            }
            return false;
          },
          // onDismissed: (DismissDirection direction) {
          //   if (direction == DismissDirection.endToStart) {
          //     onDelete?.call();
          //   } else if (direction == DismissDirection.startToEnd) {
          //     onComplete?.call(true);
          //   }
          // },
          background: _completeBackground(),
          secondaryBackground: _deleteBackground(),
          child: ListTile(
            title: Text(
              todo.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            leading: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                onComplete?.call(true);
              },
              child: const Icon(Icons.radio_button_off),
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
