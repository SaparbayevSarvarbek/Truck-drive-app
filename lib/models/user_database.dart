import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user (
            id INTEGER PRIMARY KEY,
            username TEXT,
            fullname TEXT,
            phone_number TEXT,
            status TEXT,
            profileImage TEXT
          )
        ''');
      },
    );
  }

  static Future<void> saveUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'user',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> users = await db.query('user');
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }
  static Future<void> updateProfileImage(String imagePath) async {
    final db = await database;
    await db.update(
      'user',
      {'profileImage': imagePath},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
  static Future<void> clearUser() async {
    final db = await database;
    await db.delete('user');
  }
}
