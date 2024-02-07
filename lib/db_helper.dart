import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'models/models.dart';

class DatabaseHelper {
  static const _dbName = 'todo_database.db';
  static const _dbVersion = 1;

  static const columnId = '_id';
  static const columnTitle = 'title';

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,description TEXT NOT NULL,imageBytes BLOB);''');
  }

  Future<List<Todo>> getTodos() async {
    final Database? db = await database;
    //we get the todos from database as map and convert them into dart objects
    final List<Map<String, dynamic>> maps = await db!.query('todos');
    return List.generate(maps.length, (index) => Todo.fromMap(maps[index]));
  }

  Future<void> insertTodo(Todo todo) async {
    print(todo.title);
    print(todo.description);
    final Database? db = await database;
    await db!.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(int id) async {
    final Database? db = await database;
    await db!.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future updateTodo(Todo todo) async {
    // print(todo.title);
    // print(todo.description);
    try {
      final Database? db = await database;
      await db!.update(
        'todos',
        todo.toMap(),
        where: 'id = ?',
        whereArgs: [todo.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // int updatedId = await db!.rawUpdate(
      //     'UPDATE todos SET title= ?,description = ? WHERE id = ?',
      //     [todo.title, todo.description, todo.id]);
      // print(updatedId);
      // return updatedId;
    } catch (e) {
      print(e.toString());
    }
  }
}
