import 'package:sqflite/sqflite.dart';

class DbInitilizer {
  static Future<Object> initializeDb() async {
    final db = await openDatabase(
      'pokemon.db',
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT, url TEXT)',
        );
      },
    );
    return db;
  }

  /*
  Codigo por aqui para en caso de que se necesite bueno ya sabes insertar, borar, actualizar, etc
  */
}
