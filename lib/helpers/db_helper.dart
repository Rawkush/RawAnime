import 'package:sqflite/sqflite.dart' as db;
import 'package:path/path.dart' as path;

class DBHelper {
  static final tableName = "PLACES";

  static Future<db.Database> _getDatabase() async {
    final dbPath = await db.getDatabasesPath();
    return db.openDatabase(
      path.join(dbPath, "places.db"),
      onCreate: (db, version) => db.execute(
          "CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, image TEXT)"),
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db.Database sqlDb = await DBHelper._getDatabase();
    await sqlDb.insert(tableName, data,
        conflictAlgorithm: db.ConflictAlgorithm.replace);
    await sqlDb.close();
  }

  static Future<List<Map<String, dynamic>>> fetch() async{
    final sqlDb = await DBHelper._getDatabase();
    final data = sqlDb.query(tableName);
    await sqlDb.close();
    return data;
  }
}
