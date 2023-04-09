
import '../../domain/models/todo.dart';
import '../local/entities/todo_entity.dart';

extension ToDoEntityMapper on ToDoEntity {
  ToDo asToDo() {
    return ToDo(
      id: id.toString(),
      title: title,
      complete: complete,
      synced: synced,
      deleted: deleted,
      created: created.toString(),
    );
  }
}

extension ToDoModelMapper on ToDo {
  ToDoEntity asToDoEntity() {
    return ToDoEntity(
      id: (id == '0')? null : int.parse(id),
      title: title,
      complete: complete,
      synced: synced ?? true,
      deleted: deleted ?? false,
      created: created == null? 0 : int.parse(created!),
    );
  }
}

extension ToDoListMapper on List<ToDo> {
  List<ToDoEntity> asToDoEntityList() {
    return map((e) => e.asToDoEntity()).toList();
  }
}
