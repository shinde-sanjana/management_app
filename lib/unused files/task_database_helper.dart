import 'package:sqflite/sqflite.dart' as sql;

class TASKSQLHELPER {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE data(
      id INTEGER ,
            clientname TEXT,
            projectname TEXT,
            taskname TEXT,
            taskdesc TEXT,
            startdate TEXT,
            enddate TEXT,
            stages TEXT
    )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("database_name.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createData(
      int id,
      String clientname,
      String projectname,
      String taskname,
      String taskdesc,
      DateTime startdate,
      DateTime enddate,
      String stages) async {
    final db = await TASKSQLHELPER.db();
    final data = {
      'clientname': clientname,
      'projectname': projectname,
      'taskname': taskname,
      'taskdesc': taskdesc,
      'startdate': startdate,
      'enddate': startdate,
      'stages': stages,
    };
    final id = await db.insert('data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await TASKSQLHELPER.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await TASKSQLHELPER.db();
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
      int id,
      String clientname,
      String projectname,
      String taskname,
      String taskdesc,
      DateTime startdate,
      DateTime enddate,
      String stages) async {
    final db = await TASKSQLHELPER.db();
    final data = {
      'clientname': clientname,
      'projectname': projectname,
      'taskname': taskname,
      'taskdesc': taskdesc,
      'startdate': startdate,
      'enddate': startdate,
      'stages': stages,
    };
    final result =
        await db.update('data', data, where: "id =?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await TASKSQLHELPER.db();
    try {
      await db.delete('data', where: "id=?", whereArgs: [id]);
    } catch (e) {}
  }

  static Future<void> deleteAllData() async {
    final db = await TASKSQLHELPER.db();
    try {
      await db.delete('data');
      // ignore: empty_catches
    } catch (e) {}
  }
}
