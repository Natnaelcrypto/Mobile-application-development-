import 'package:path/path.dart';
import 'package:pro/task/model/task_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

class TaskDbHelper {
  final int version = 1;
  late Database db;

  static final TaskDbHelper _dbHelper = TaskDbHelper._internal();
  TaskDbHelper._internal();
  factory TaskDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'her7.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Task(taskid Text, title Text, detail TEXT, status INTEGER, userID TEXT, date_created TEXT, farmname TEXT, assgined_to TEXT)');
    }, version: version);

    return db;
  }

  Future<int> insertTask(Task task) async {
    print(task.toString());
    return await db.insert(
      'Task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    await db.update(
      'Task',
      task.toMap(),
      where: "taskid = ?",
      whereArgs: [task.id],
    );
  }

  Future<List<Task>> getTaskLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Task');
    return List.generate(maps.length, (i) {
      print(maps[i]['taskid']);
      print("fromm local");
      return Task(
        title: maps[i]['title'],
        detail: maps[i]['detail'],
        status: (maps[i]['status'] == 1) ? true : false,
        id: maps[i]['taskid'],
        date_created: maps[i]['date_created'],
        farmname: maps[i]['farmname'],
        assgined_to: maps[i]['assgined_to'],
      );
    }).toList();
  }

  Future<int> deletetask(String id) async {
    int result = await db.delete("Task", where: "taskid = ?", whereArgs: [id]);
    return result;
  }
}
