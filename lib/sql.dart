import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeDataLocally(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String?> retrieveDataLocally(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

class Sql {
  // late Database _database;
  // open() async {
  //   _database = await openDatabase('local_db.db', version: 1,
  //       onCreate: (Database db, int version) async {
  //     await db.execute('create table items(' ')');
  //   });
  // }
}
