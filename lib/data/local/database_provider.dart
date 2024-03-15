import 'package:attendance/data/model/attendance_model.dart';
import 'package:attendance/data/model/location_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider{

  static DatabaseProvider? _databaseProvider;

  DatabaseProvider._instance() {
    _databaseProvider = this;
  }

  factory DatabaseProvider() => _databaseProvider ?? DatabaseProvider._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }
  
  final String dbName = 'attendance.db';
  final String locationTableName = 'location';
  final String attendanceTableName = 'attendance';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/$dbName';

    var db = await openDatabase(
      databasePath, 
      version: 1, 
      onCreate: _onCreate
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $locationTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT,
        latitude REAL,
        longitude REAL,
        createdAt INTEGER);
    ''');
    await db.execute('''
      CREATE TABLE $attendanceTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        type TEXT,
        status TEXT, 
        pinLatitude REAL,
        pinLongitude REAL,
        latitude REAL,
        longitude REAL,
        distance REAL,
        createdAt INTEGER);
    ''');
  }

  Future<int> insertLocation(LocationModel location) async {
    final db = await database;
    return await db!.insert(locationTableName, location.toMap());
  }

  Future<LocationModel> getLocation() async {

    final db = await database;
    List<Map<String, dynamic>> results =
      await db!.query(
          locationTableName,
        limit: 1
      );
    if(results.isEmpty){
      return LocationModel(
          title: "",
          latitude: 0.0,
          longitude: 0.0,
          createdAt: DateTime.now());
    }
    return results.map((res) => LocationModel.fromMap(res)).first;
  }

  Future<void> deleteLocation() async {
    final db = await database;

    await db!.rawDelete("DELETE FROM $locationTableName");
  }

  Future<int> insertAttendance(AttendanceModel attendance) async {
    final db = await database;
    return await db!.insert(attendanceTableName, attendance.toMap());
  }

  // Future<int> insertAttendance(List<AttendanceModel> attendances) async {
  //   final db = await database;
  //   final batch = db!.batch();
  //
  //   for (AttendanceModel data in attendances) {
  //     batch.insert(attendanceTableName, data.toMap());
  //   }
  //
  //   final List<dynamic> result = await batch.commit();
  //   final int affectedRows = result.reduce((sum, element) => sum + element);
  //   return affectedRows;
  // }

  Future<List<AttendanceModel>> getAttendanceList() async {
    final db = await database;

    List<Map<String, dynamic>> results =
      await db!.query(
        attendanceTableName,
        orderBy: "createdAt DESC"
      );

    return List.generate(results.length, (i) {
      return AttendanceModel.fromMap(results[i]);
    });
  }

  Future<void> deleteAttendance() async {
    final db = await database;

    await db!.rawDelete("DELETE FROM $attendanceTableName");
  }


  Future<void> deleteAll() async {
    final db = await database;

    await db!.rawDelete("DELETE FROM $locationTableName");
    await db!.rawDelete("DELETE FROM $attendanceTableName");
  }
}