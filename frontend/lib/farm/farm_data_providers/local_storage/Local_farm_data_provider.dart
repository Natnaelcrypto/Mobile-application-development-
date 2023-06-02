import 'package:path/path.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/user/model/user_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

import '../../farm_model/farm_model.dart';

class FarmDbHelper {
  final int version = 1;
  late Database db;

  static final FarmDbHelper _dbHelper = FarmDbHelper._internal();
  FarmDbHelper._internal();
  factory FarmDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'Farm1.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS Farm(userID Text, farmName Text, expirationDate TEXT, itemName TEXT, dosage TEXT, instructions TEXT, FarmId TEXT, brand TEXT, type TEXT, isfeed INTEGER, ismedication INTEGER, quantity TEXT)');
    }, version: version);

    return db;
  }

  Future<int> insertfarm(Farm farm) async {
    return await db.insert(
      'Farm',
      farm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updatefarm(Farm farm) async {
    await db.update(
      'Farm',
      farm.toMap(),
      where: "FarmId = ?",
      whereArgs: [farm.id_],
    );
  }

  Future<List<Farm>> getfarmLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('Farm');
    return List.generate(maps.length, (i) {
      return Farm(
        userID: maps[i]["userID"],
        farmName: maps[i]["farmName"],
        id_: maps[i]["FarmId"],
        expirationDate: maps[i]["expirationDate"],
        itemName: maps[i]["itemName"],
        dosage: maps[i]["dosage"],
        instructions: maps[i]["instructions"],
        isfeed: (maps[i]["isfeed"] == 1) ? true : false,
        ismedication: (maps[i]["ismedication"] == 1) ? true : false,
        quantity: maps[i]["quantity"],
        brand: maps[i]["brand"],
        type: maps[i]["type"],
      );
    }).toList();
  }

  Future<int> deletefarm(String id) async {
    int result = await db.delete("Farm", where: "FarmId = ?", whereArgs: [id]);
    return result;
  }
}
