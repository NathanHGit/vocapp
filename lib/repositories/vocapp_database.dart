import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocapp/model/voc.dart';
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

  Future<List<Voc>> getVoc() async {
    final db = await instance.database;
    List<Map> res = await db.rawQuery(
        'SELECT voc.id, lemma, inflections, translation, pos.name FROM voc, pos, status WHERE voc.pos = pos.id AND voc.status = status.id AND DATE("now", status.name + " day") AND status.name NOT IN ("known", "unknown")');

    List<Voc> voc = [];

    res.forEach((element) {
      Voc obj = Voc.fromMap(element);
      voc.add(obj);
    });

    int limit = 20 - res.length > 5 ? 5 : 20 - res.length;
    res = await db.rawQuery(
        'SELECT voc.id, lemma, inflections, translation, pos.name FROM voc, pos, status WHERE voc.pos = pos.id AND voc.status = status.id AND status.name = "unknown" ORDER BY RANDOM() LIMIT $limit');

    res.forEach((element) {
      Voc obj = Voc.fromMap(element);
      voc.add(obj);
    });

    return voc;
  }

  Future<double> getProgression() async {
    final db = await instance.database;
    List<Map> res = await db.rawQuery(
        'SELECT (SELECT COUNT(voc.id) FROM voc WHERE status = 7) / (SELECT COUNT(voc.id) FROM voc) as progression');

    return res[0]['progression'].toDouble();
  }

  void delayedVocDates(int diff) async {
    final db = await instance.database;
    await db.execute('UPDATE voc SET date = DATE(date, "$diff day")');
  }

  void pushTraining() async {
    final db = await instance.database;
    //Gérer statut entre 0 et 7
    await db.execute('UPDATE voc SET status = status + modif, modif = 0, date = DATE("now") WHERE modif != 0');
  }

  void updateVoc(Voc voc) async {
    final db = await instance.database;
    //Gérer statut entre 0 et 7
    await db.execute('UPDATE voc SET modif = $voc.modif WHERE id = $voc.id');
  }

  Future<DateTime> getLastUpdate() async {
    final db = await instance.database;
    List<Map> res = await db.query('app', columns: ['lastUpdate']);
    return DateTime.parse(res[0]['lastUpdate']);
  }

  void setLastUpdate() async {
    final db = await instance.database;
    await db.execute('UPDATE app SET lastUpdate = DATE("now")');
  }
}
