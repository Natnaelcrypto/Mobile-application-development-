import 'package:path/path.dart';
import 'package:pro/task/model/task_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../model/herd_model.dart';

class HerdDbHelper {
  final int version = 1;
  late Database db;

  static final HerdDbHelper _dbHelper = HerdDbHelper._internal();
  HerdDbHelper._internal();
  factory HerdDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'Herd2.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Herd(farmname Text, herdID Text, age TEXT, bread TEXT,  gender TEXT, Herdids TEXT)');
    }, version: version);

    return db;
  }

  Future<int> insertHerd(Herd herd) async {
    print(herd.toString());
    return await db.insert(
      'Herd',
      herd.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateHerd(Herd herd) async {
    print(herd.bread);
    print("Updatinggg");
    await db.update(
      'Herd',
      herd.toMap(),
      where: "Herdids = ?",
      whereArgs: [herd.id],
    );
  }

  Future<List<Herd>> getHerdLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Herd');
    return List.generate(
      maps.length,
      (i) {
        return Herd(
          farmname: maps[i]["farmname"],
          herdID: maps[i]["herdID"],
          age: maps[i]["age"],
          bread: maps[i]["bread"],
          health_history: [],
          vaccination: [],
          medication: [],
          pregnancy: [],
          gender: maps[i]["gender"],
          id: maps[i]["Herdids"],
        );
      },
    ).toList();
  }

  Future<int> deleteherd(String id) async {
    int result = await db.delete("Herd", where: "Herdids = ?", whereArgs: [id]);
    print(result);
    return result;
  }
}
