import '../models/todo.dart';

abstract class DbRepository {
  Future<List<ToDo>> getToDos();
  Stream<List<ToDo>> getToDosAsStream();
  Future<int> storeToDo(ToDo toDo);
  Future<void> updateToDo(ToDo toDo);
  Future<void> setToDoAsDeleted(ToDo toDo); // TODO use only id
  Future<void> setToDoAsSyncedById(int id);
  Future<void> updateAll(List<ToDo> todos);
}