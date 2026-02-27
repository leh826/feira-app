import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'docampo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT,
            senha TEXT,
            regiao TEXT,
            cidade TEXT,
            bairro TEXT,
            numero TEXT
          )
        ''');
        
        await db.insert('users', {
          'nome': 'Ana Silva',
          'email': 'ana.silva@email.com',
          'senha': '123',
          'regiao': 'Norte',
          'cidade': 'Castanhal',
          'bairro': 'Centro',
          'numero': '101'
        });
      },
    );
  }

  Future<Map<String, dynamic>?> login(String email, String senha) async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return res.isNotEmpty ? res.first : null;
  }
}