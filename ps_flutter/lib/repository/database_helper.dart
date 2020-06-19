import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Instancia do SQFLite Database
  static Database _database;

  // Instancia da classe Helper
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  // Fábrica de construtor
  factory DatabaseHelper() {
    return _instance;
  }

  // Construtor nomeado 
  DatabaseHelper._internal();

  

  // Abre conexão com o banco
  Future<Database> get connection async {
    if (_database == null) {
      _database = await _createDatabase();
    }
    return _database;
  }

  Future<Database> _createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'chat.db');

    var database = await openDatabase(
      dbPath,
      version: 2,
      onCreate: _createTables,
    );

    return database;
  }

  void _createTables(Database database, int version) async {
    
    await database.execute(
      '''
      CREATE TABLE ChatModel (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        tipo TEXT,
        status TEXT,
        conteudo TEXT
      )
      ''',
      
      
    );
    await database.execute(
      '''
      CREATE TABLE ChatMessage (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        type NUMERIC,
        texto TEXT
        
      )
      ''',
      
      
    );
  }
}
