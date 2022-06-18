import 'package:flutter_todo/model/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksDatabase {
  static final TasksDatabase instance = TasksDatabase._init();

  static Database? _database;

  TasksDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableTasks (
  ${NoteTasks.id} $idType,
  ${NoteTasks.isImportant} $boolType,
  ${NoteTasks.number} $integerType,
  ${NoteTasks.title} $textType,
  ${NoteTasks.description} $textType,
  ${NoteTasks.time} $textType
)
''');
  }

  Future<TaskModel> create(TaskModel task) async {
    final db = await instance.database;

    final id = await db.insert(tableTasks, task.toJson());
    return task.copy(id: id);
  }

  Future<TaskModel> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableTasks,
      where: '${NoteTasks.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<TaskModel>> readAllTasks() async {
    final db = await instance.database;

    final result = await db.query(tableTasks);

    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await instance.database;

    return db.update(
      tableTasks,
      task.toJson(),
      where: '${NoteTasks.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;

    return db.delete(
      tableTasks,
      where: '${NoteTasks.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
