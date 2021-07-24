import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocapp/models/voc.dart';
import 'package:flutter/services.dart' show rootBundle;

class VocappDatabase {
  static final VocappDatabase instance = VocappDatabase._init();

  static Database? _database;

  VocappDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, 'vocapp.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future deleteDatabase() async => databaseFactory.deleteDatabase(join(await getDatabasesPath(), 'vocapp.db'));

  Future _createDB(Database db, int version) async {
    print("DB creation");

    var batch = db.batch();

    var data = (await rootBundle.loadString('assets/vocapp.sql')).split(";");
    data.removeLast();

    data.forEach((cmd) {
      batch.execute(cmd);
    });
    await batch.commit();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  /*Future test() async {
    final db = await instance.database;

    List<Map> res = await db
        .rawQuery('SELECT DATE(date, status.name) from voc, status where voc.status = status.id and voc.id = 2');

    print(res);
  }*/

  Future<List<Voc>> getVoc(bool rand) async {
    print("GET VOC");
    final db = await instance.database;

    List<Voc> voc = [];

    List<Map> res = await db.rawQuery(
        'SELECT voc.id, lemma, inflections, translation, pos.name, weight FROM voc, pos, status WHERE voc.pos = pos.id AND voc.status = status.id AND ((DATE("now","localtime") = DATE(date, status.name) AND status NOT IN (1, 7)) OR weight IS NOT NULL)');

    res.forEach((element) {
      Voc obj = Voc.fromMap(element);
      voc.add(obj);
    });

    if (rand && res.length < 24) {
      int limit = 24 - res.length < 3 ? 24 - res.length : 3;
      res = await db.rawQuery(
          'SELECT voc.id, lemma, inflections, translation, pos.name, weight FROM voc, pos WHERE voc.pos = pos.id AND status = 1 ORDER BY RANDOM() LIMIT $limit');

      res.forEach((element) {
        Voc obj = Voc.fromMap(element);
        voc.add(obj);
      });
    }

    return voc;
  }

  Future<double> getProgression() async {
    final db = await instance.database;
    List<Map> res = await db.rawQuery(
        'SELECT SUM((0.111*(status-1))*(0.111*(status-1))) / (SELECT COUNT(id) FROM voc) as progression FROM voc');

    return double.parse((res[0]['progression']).toStringAsFixed(2));
  }

  void postponeDates(int diff) async {
    print("POSTPONE DATES");
    final db = await instance.database;
    await db.execute('UPDATE voc SET date = DATE(date, "$diff day")');
  }

  void pushTraining(DateTime dateTime) async {
    print("PUSH TRAINING");
    final db = await instance.database;
    String date = dateTime.toString().split(" ")[0];
    await db.execute(
        'UPDATE voc SET status = (CASE WHEN (status + weight) > 10 THEN 10 WHEN (status + weight) < 1 THEN 1 ELSE (status + weight) END), weight = NULL, date = "$date" WHERE weight IS NOT NULL');
  }

  void updateWeight(Voc voc) async {
    final db = await instance.database;
    final int weight = voc.weight;
    final int id = voc.id;
    await db.execute('UPDATE voc SET weight = $weight WHERE id = $id');
  }

  Future<DateTime> getLastUpdate() async {
    final db = await instance.database;
    List<Map> res = await db.query('app', columns: ['lastUpdate']);
    return DateTime.parse(res[0]['lastUpdate']);
  }

  void setLastUpdate() async {
    final db = await instance.database;
    await db.execute('UPDATE app SET lastUpdate = DATE("now","localtime")');
  }
}
