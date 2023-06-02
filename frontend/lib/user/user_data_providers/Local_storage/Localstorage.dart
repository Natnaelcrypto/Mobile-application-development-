import 'package:path/path.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/user/model/user_model.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';

class UserDbHelper {
  final int version = 1;
  late Database db;

  static final UserDbHelper _dbHelper = UserDbHelper._internal();
  UserDbHelper._internal();
  factory UserDbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    db = await openDatabase(join(await getDatabasesPath(), 'User.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS User(fristName Text, lastName Text, password TEXT, userName TEXT, Role TEXT, userId TEXT, farmName TEXT)');
    }, version: version);

    return db;
  }

  Future<int> insertuser(User user) async {
    print(user.toString());
    return await db.insert(
      'User',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateuser(User user) async {
    await db.update(
      'User',
      user.toMap(),
      where: "userId = ?",
      whereArgs: [user.id],
    );
  }

  Future<List<User>> getuserLists() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      print(maps[i]['fristName']);
      print(maps[i]['Role']);
      print("fromm local");
      return User(
        fristName: maps[i]["fristName"],
        lastName: maps[i]["lastName"],
        password: maps[i]["password"],
        userName: maps[i]["userName"],
        Role: maps[i]["Role"],
        id: maps[i]["userId"],
        farmName: maps[i]["farmName"],
      );
    }).toList();
  }

  Future<int> deleteuser(String id) async {
    int result = await db.delete("User", where: "userId = ?", whereArgs: [id]);

    return result;
  }
}
