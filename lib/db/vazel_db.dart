import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vazel/models/scan_model.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();

  static Database _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('carrito.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';

    await db.execute('''
CREATE TABLE $tableNotes ( 
 id $idType, 
  nombre $textType,
  cara $textType,
  asientos $textType,
  elastomeros $textType,
  partesMetalicas $textType,
  dimensiones $textType,
  cantidad $textType,
  imagen $textType
  )
''');
  }

  // Agregar un producto al carrito
  Future<int> create(ScanModel note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return id;
  }

  //Leer todos los ficheros en la base de datos
  Future<List<ScanModel>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableNotes);

    return result.map((json) => ScanModel.fromJson(json)).toList();
  }

  //Actualizar un Producto
  Future<int> update(ScanModel note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //Borrar un Producto
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
