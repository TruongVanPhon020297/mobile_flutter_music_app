import 'package:music_app/model/song.dart';
import 'package:sqflite/sqflite.dart' as sql;


class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("CREATE TABLE songs(id INTEGER PRIMARY KEY,songTitle TEXT,preview TEXT,artistName TEXT,pictureSmall TEXT,pictureMedium TEXT,pictureBig TEXT)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'song.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<void> insertTrack(Song song) async {
    final db = await DatabaseHelper.db();
    await db.insert(
      'songs',
      song.toMap(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    print("Insert Data Success");

  }

  Future<List<Song>> getAllSongDatabase() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('songs');

    return List.generate(maps.length, (i) {
      return Song.allProperties(
          id: maps[i]['id'],
          songTitle: maps[i]['songTitle'],
          preview: maps[i]['preview'],
          artistName: maps[i]['artistName'],
          pictureSmall: maps[i]['pictureSmall'],
          pictureMedium: maps[i]['pictureMedium'],
          pictureBig: maps[i]['pictureBig']
      );
    });
  }

}