import '../models/todo.dart';

abstract class DbRepository {
  Stream<List<ToDo>> getToDosAsStream();
  Future<ToDo?> getToDoById(int id);
  Future<int> storeToDo(ToDo toDo);
  Future<void> updateToDo(ToDo toDo);
  Future<void> setToDoAsDeleted(ToDo toDo); // TODO use only id
  Future<void> setToDoAsSyncedById(int id);
  Future<void> updateAll(List<ToDo> todos);
  Future<void> delete(ToDo todo);
}