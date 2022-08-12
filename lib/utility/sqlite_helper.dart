import 'package:flowdetect/models/sqlite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteHelper {
  final String nameDatabase = 'flowdetact.db';
  final int varsionDatabase = 1;
  final String tableDatabase = 'videotable';
  final String columnId = 'id';
  final String columnDateTime = 'recordDataTime';
  final String columnChanel = 'chanel';
  final String columnPathStroage = 'pathStorage';

  SQLiteHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDatabase (id INTEGER PRIMARY KEY, $columnDateTime TEXT, $columnChanel TEXT, $columnPathStroage TEXT)'),
      version: varsionDatabase,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<void> insertData({required SQLiteModel sqLiteModel}) async {
    Database database = await connectedDatabase();
    database.insert(
      tableDatabase,
      sqLiteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SQLiteModel>> readAllData() async {
    var sqliteModels = <SQLiteModel>[];

    Database database = await connectedDatabase();
    var maps = await database.query(tableDatabase);
    for (var element in maps) {
      SQLiteModel sqLiteModel = SQLiteModel.fromMap(element);
      sqliteModels.add(sqLiteModel);
    }

    return sqliteModels;
  }

  Future<void> deleteWhereId({required int idDelete}) async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase, where: '$columnId = $idDelete');
  }

  Future<void> deleteAll() async {
    Database database = await connectedDatabase();
    await database.delete(tableDatabase);
  }

  Future<void> editData(
      {required int idEdit, required SQLiteModel sqLiteModel}) async {
    Database database = await connectedDatabase();
    await database
        .update(tableDatabase, sqLiteModel.toMap(),
            where: '$columnId = $idEdit')
        .then((value) {
      // print('Edit SQLite Success');
    });
  }
}
