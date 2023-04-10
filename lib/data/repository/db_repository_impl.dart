import '../../domain/models/todo.dart';
import '../../domain/repositories/db_repository.dart';
import '../local/app_db.dart';
import '../mappers/todo_mapper.dart';

class DbRepositoryImpl implements DbRepository {
  final AppDb _appDb;

  DbRepositoryImpl(this._appDb);

  @override
  Future<ToDo?> getToDoById(int id) {
    return _appDb.todosDao.getById(id).then((value) => value?.asToDo());
  }

  @override
  Future<void> setToDoAsDeleted(ToDo toDo) {
    return _appDb.todosDao.setAsDeleted(int.parse(toDo.id));
  }

  @override
  Future<int> storeToDo(ToDo toDo) {
    return _appDb.todosDao.insertToDo(toDo.asToDoEntity());
  }

  @override
  Future<void> updateToDo(ToDo toDo) {
    return _appDb.todosDao.update(toDo.asToDoEntity());
  }

  @override
  Stream<List<ToDo>> getToDosAsStream() {
    return _appDb.todosDao
        .getAllActiveAsStream()
        .map((event) => event.map((e) => e.asToDo()).toList());
  }

  @override
  Future<void> updateAll(List<ToDo> todos) {
    return _appDb.todosDao.updateAll(todos.asToDoEntityList());
  }

  @override
  Future<void> setToDoAsSyncedById(int id) {
    return _appDb.todosDao.setAsSyncedById(id);
  }

  @override
  Future<void> delete(ToDo todo) {
    return _appDb.todosDao.deleteToDo(todo.asToDoEntity());
  }
}
