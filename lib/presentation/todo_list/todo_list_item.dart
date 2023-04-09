import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoListItem extends StatelessWidget {
  final ToDo todo;
  const TodoListItem(this.todo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
