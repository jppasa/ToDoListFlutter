import 'package:floor/floor.dart';

import '../../../../utils/constants.dart';
import '../entities/todo_entity.dart';

@dao
abstract class ToDoDao {
  @Query("SELECT * FROM $todosTable")
  Future<List<ToDoEntity>> getAllToDos();

  @Query("SELECT * FROM $todosTable ORDER BY complete, created DESC")
  Stream<List<ToDoEntity>> getAllToDosAsStream();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertToDo(ToDoEntity toDo);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insert(List<ToDoEntity> toDos);

  @Query("UPDATE SET deleted = 1 FROM $todosTable WHERE id = :id")
  Future<void> setAsDeleted(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> update(ToDoEntity toDo);

  @Query("DELETE FROM $todosTable")
  Future<void> deleteAll();

  @transaction
  Future<void> updateAll(List<ToDoEntity> todos) async {
    await deleteAll();
    await insert(todos);
  }

  @Query('UPDATE $todosTable SET synced = 1 WHERE id = :id')
  Future<void> setAsSyncedById(int id);
}