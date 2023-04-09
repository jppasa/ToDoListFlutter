import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/todo_dao.dart';
import 'entities/todo_entity.dart';

part 'app_db.g.dart';

@Database(version: 1, entities: [ToDoEntity])
abstract class AppDb extends FloorDatabase {
  ToDoDao get todosDao;
}