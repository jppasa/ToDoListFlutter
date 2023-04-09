// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDbBuilder databaseBuilder(String name) => _$AppDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDbBuilder inMemoryDatabaseBuilder() => _$AppDbBuilder(null);
}

class _$AppDbBuilder {
  _$AppDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDb extends AppDb {
  _$AppDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ToDoDao? _todosDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `complete` INTEGER NOT NULL, `synced` INTEGER NOT NULL, `deleted` INTEGER NOT NULL, `created` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ToDoDao get todosDao {
    return _todosDaoInstance ??= _$ToDoDao(database, changeListener);
  }
}

class _$ToDoDao extends ToDoDao {
  _$ToDoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _toDoEntityInsertionAdapter = InsertionAdapter(
            database,
            'todos',
            (ToDoEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'complete': item.complete ? 1 : 0,
                  'synced': item.synced ? 1 : 0,
                  'deleted': item.deleted ? 1 : 0,
                  'created': item.created
                },
            changeListener),
        _toDoEntityUpdateAdapter = UpdateAdapter(
            database,
            'todos',
            ['id'],
            (ToDoEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'complete': item.complete ? 1 : 0,
                  'synced': item.synced ? 1 : 0,
                  'deleted': item.deleted ? 1 : 0,
                  'created': item.created
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDoEntity> _toDoEntityInsertionAdapter;

  final UpdateAdapter<ToDoEntity> _toDoEntityUpdateAdapter;

  @override
  Future<List<ToDoEntity>> getAllToDos() async {
    return _queryAdapter.queryList('SELECT * FROM todos',
        mapper: (Map<String, Object?> row) => ToDoEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            complete: (row['complete'] as int) != 0,
            synced: (row['synced'] as int) != 0,
            deleted: (row['deleted'] as int) != 0,
            created: row['created'] as int));
  }

  @override
  Stream<List<ToDoEntity>> getAllActiveAsStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM todos WHERE deleted = 0 ORDER BY complete, created DESC',
        mapper: (Map<String, Object?> row) => ToDoEntity(
            id: row['id'] as int?,
            title: row['title'] as String,
            complete: (row['complete'] as int) != 0,
            synced: (row['synced'] as int) != 0,
            deleted: (row['deleted'] as int) != 0,
            created: row['created'] as int),
        queryableName: 'todos',
        isView: false);
  }

  @override
  Future<void> setAsDeleted(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE SET deleted = 1 FROM todos WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('DELETE FROM todos');
  }

  @override
  Future<void> setAsSyncedById(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE todos SET synced = 1 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<int> insertToDo(ToDoEntity toDo) {
    return _toDoEntityInsertionAdapter.insertAndReturnId(
        toDo, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insert(List<ToDoEntity> toDos) {
    return _toDoEntityInsertionAdapter.insertListAndReturnIds(
        toDos, OnConflictStrategy.replace);
  }

  @override
  Future<void> update(ToDoEntity toDo) async {
    await _toDoEntityUpdateAdapter.update(toDo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAll(List<ToDoEntity> todos) async {
    if (database is sqflite.Transaction) {
      await super.updateAll(todos);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDb(changeListener)
          ..database = transaction;
        await transactionDatabase.todosDao.updateAll(todos);
      });
    }
  }
}
