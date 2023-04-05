import 'package:floor/floor.dart';

import '../../../../utils/constants.dart';
import '../entities/todo_entity.dart';

@dao
abstract class ToDoDao {
  @Query("SELECT * FROM $todosTable")
  Future<List<ToDoEntity>> getAllToDos();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertToDo(ToDoEntity toDo);


}