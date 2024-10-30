import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/blood_pressure_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('blood_pressure.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableBloodPressure (
        ${BloodPressureFields.id} $idType,
        ${BloodPressureFields.systolic} $intType,
        ${BloodPressureFields.diastolic} $intType,
        ${BloodPressureFields.pulse} $intType,
        ${BloodPressureFields.dateTime} $textType
      )
    ''');
  }

  Future<int> insertBloodPressure(BloodPressure bp) async {
    final db = await instance.database;
    final map = bp.toMap();
    map.remove(BloodPressureFields.id);
    return await db.insert(tableBloodPressure, map);
  }

  Future<BloodPressure?> getBloodPressure(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableBloodPressure,
      columns: BloodPressureFields.values,
      where: '${BloodPressureFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return BloodPressure.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<BloodPressure>> getAllBloodPressures() async {
    final db = await instance.database;

    const orderBy = '${BloodPressureFields.dateTime} ASC';
    final result = await db.query(tableBloodPressure, orderBy: orderBy);

    return result.map((json) => BloodPressure.fromMap(json)).toList();
  }

  Future<int> updateBloodPressure(BloodPressure bp) async {
    final db = await instance.database;

    return db.update(
      tableBloodPressure,
      bp.toMap(),
      where: '${BloodPressureFields.id} = ?',
      whereArgs: [bp.id],
    );
  }

  Future<int> deleteBloodPressure(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableBloodPressure,
      where: '${BloodPressureFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

const String tableBloodPressure = 'bloodPressures';

class BloodPressureFields {
  static final List<String> values = [
    id, systolic, diastolic, pulse, dateTime
  ];

  static const String id = 'id';
  static const String systolic = 'systolic';
  static const String diastolic = 'diastolic';
  static const String pulse = 'pulse';
  static const String dateTime = 'dateTime';
}
