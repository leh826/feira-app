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
    String path = join(await getDatabasesPath(), 'eguadafeira.db');
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
        
        // Inserindo usuário de teste inicial
        await db.insert('users', {
          'nome': 'Bruna Oliveira',
          'email': 'bruna@gmail.com',
          'senha': '123',
          'regiao': 'Norte',
          'cidade': 'Belém',
          'bairro': 'Centro',
          'numero': '101'
        });
        await db.insert('users', {
          'nome': 'Ana Julia',
          'email': 'ana@gmail.com',
          'senha': '123456789',
          'regiao': 'Norte',
          'cidade': 'Castanhal',
          'bairro': 'Centro',
          'numero': '102'
        });
      },
    );
  }

  // Realiza o login buscando as credenciais
  Future<Map<String, dynamic>?> login(String email, String senha) async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.query(
      'users',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return res.isNotEmpty ? res.first : null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }
}