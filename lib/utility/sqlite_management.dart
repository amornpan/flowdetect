import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flowdetect/models/hii_station_model.dart';
import 'package:flowdetect/models/other_river_model.dart';

class SQLiteManagement {
  final String nameDatabase = 'flowdetectdb.db';
  final int varsionDatabase = 1;

  final String tbHiiStation = 'tbHiiStation';
  final String idHii = 'idHii';
  final String name = 'name';
  final String date = 'date';
  final String time = 'time';
  final String water = 'water';
  final String leftBank = 'leftBank';
  final String rightBank = 'rightBank';
  final String groundBevel = 'groundBevel';
  final String lat = 'lat';
  final String lng = 'lng';
  final String particleSize = 'particleSize';
  final String recordDataTime = 'recordDataTime';
  final String devicePathStorage = 'devicePathStorage';
  final String averageVelocyty = 'averageVelocyty';
  final String surfaceVelocity = 'surfaceVelocity';
  final String flowrate = 'flowrate';
  final String flagStatus = 'flagStatus';

  final String tbOtherRiver = 'tbOtherRiver';
  final String idOther = 'idOther';
  final String bVal = 'bVal';
  final String yVal = 'yVal';
  final String aVal = 'aVal';
  final String otherRiverparticleSize = 'otherRiverparticleSize';
  final String otherRiverrecordDataTime = 'otherRiverrecordDataTime';
  final String otherRiverdevicePathStorage = 'otherRiverdevicePathStorage';
  final String otherRiversurfaceVelocity = 'otherRiversurfaceVelocity';
  final String otherRiveraverageVelocyty = 'otherRiveraverageVelocyty';
  final String otherRiverflowrate = 'otherRiverflowrate';
  final String otherRiverflagStatus = 'otherRiverflagStatus';

  SQLiteManament() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $tbHiiStation (id INTEGER PRIMARY KEY, $name TEXT, $date TEXT, $time TEXT, $water TEXT, $leftBank TEXT, $rightBank TEXT,  $groundBevel TEXT, $lat TEXT, $lng TEXT, $particleSize TEXT, $recordDataTime TEXT, $devicePathStorage TEXT, $averageVelocyty TEXT, $surfaceVelocity TEXT, $flowrate TEXT, $flagStatus TEXT)');
        await db.execute(
            'CREATE TABLE $tbOtherRiver (id INTEGER PRIMARY KEY, $bVal TEXT, $yVal TEXT, $aVal TEXT, $otherRiverparticleSize TEXT, $otherRiverrecordDataTime TEXT, $otherRiverdevicePathStorage TEXT,  $otherRiversurfaceVelocity TEXT, $otherRiveraverageVelocyty TEXT, $otherRiverflowrate TEXT, $otherRiverflagStatus TEXT)');
      },
      version: varsionDatabase,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  // Select

  Future readHiiStation() async {
    Database database = await connectedDatabase();
    final res = await database
        .rawQuery("SELECT * FROM tbHiiStation ORDER BY idHii DESC LIMIT 1;");
    return res;
  }

  Future<List<HiiStationModel>> readHiiStationAll() async {
    Database database = await connectedDatabase();
    var hiiStationModels = <HiiStationModel>[];

    List<Map<String, dynamic>> maps = await database.query(tbHiiStation);
    if (maps.isNotEmpty) {
      for (var item in maps) {
        HiiStationModel hiiStationModel = HiiStationModel.fromMap(item);
        hiiStationModels.add(hiiStationModel);
      }
    }
    return hiiStationModels;
  }

  Future<List<OtherRiverModel>> readOtherRiverAll() async {
    Database database = await connectedDatabase();
    var otherRiverModels = <OtherRiverModel>[];

    List<Map<String, dynamic>> maps = await database.query(tbOtherRiver);
    if (maps.isNotEmpty) {
      for (var item in maps) {
        OtherRiverModel otherRiverModel = OtherRiverModel.fromMap(item);
        otherRiverModels.add(otherRiverModel);
      }
    }
    return otherRiverModels;
  }

  // Insert
  Future<void> insertHiiStation(
      {required HiiStationModel hiiStationModel}) async {
    Database database = await connectedDatabase();
    print('insertHiiStation work');
    try {
      database.insert(
        tbHiiStation,
        hiiStationModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insertHiiStation Success');
    } catch (e) {
      print('e insertHiiStation ==> ${e.toString()}');
    }
  }

  Future<void> insertOtherRiver(OtherRiverModel otherRiverModel) async {
    Database database = await connectedDatabase();
    print('insertOtherRiver work');
    try {
      database.insert(
        tbOtherRiver,
        otherRiverModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insertOtherRiver Success');
    } catch (e) {
      print('e insertOtherRiver ==> ${e.toString()}');
    }
  }

  //Update
  Future<void> editHiiStation(
      {required int ididHiiEdit,
      required HiiStationModel hiiStationModel}) async {
    Database database = await connectedDatabase();
    await database
        .update(tbHiiStation, hiiStationModel.toMap(),
            where: '$idHii = $ididHiiEdit')
        .then((value) {
      // print('Edit SQLite Success');
    });
  }

  Future<void> editOtherRiver(
      {required int idOtherEdit,
      required OtherRiverModel otherRiverModel}) async {
    Database database = await connectedDatabase();
    await database
        .update(tbOtherRiver, otherRiverModel.toMap(),
            where: '$idOther = $idOtherEdit')
        .then((value) {
      // print('Edit SQLite Success');
    });
  }

  //Delete
  Future<void> deleteHiiStationWhereId({required int idHiiDelete}) async {
    Database database = await connectedDatabase();
    await database.delete(tbHiiStation, where: '$idHii = $idHiiDelete');
  }

  Future<void> deleteOtherRiverWhereId({required int idOtherDelete}) async {
    Database database = await connectedDatabase();
    await database.delete(tbOtherRiver, where: '$idOther = $idOtherDelete');
  }
}
