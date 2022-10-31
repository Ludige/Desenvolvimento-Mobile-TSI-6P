import 'package:listas/product_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? _db;

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database?> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'productDatabase.db');

    try {
      return _db = await openDatabase(path,
          version: 1, onCreate: _onCreateDB, onUpgrade: _onUpgradeDB);
    } catch (error) {
      print(error);
    }
  }

  Future _onCreateDB(Database db, int newVersion) async {
    await db.execute(ProductHelper.createScript);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute("DROP TABLE ${ProductHelper.tableName};");
      await _onCreateDB(db, newVersion);
    }
  }
}
