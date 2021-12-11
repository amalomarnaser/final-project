import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:untitled9/models/MovieInfo.dart';


class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  static final String dbName = 'favorite.db';
  static final String tableName = 'favorite';
  static final String titleColumn = 'title';
  static final String yearColumn = 'year';
  static final String genreColumn = 'genre';
  static final String plotColumn = 'plot';
  static final String posterColumn = 'poster';
  static final String imdbRatingColumn = 'imdbRating';

  Database database;
  initDatabase() async {
    database = await createConnection();
  }

  Future<Database> createConnection() async {
    Directory directory = await getApplicationDocumentsDirectory();

    Database database = await openDatabase(join(directory.path, dbName),
        version: 1, onCreate: (db, version) {
      db.execute(
          '''CREATE TABLE $tableName ($titleColumn TEXT , $yearColumn TEXT , $genreColumn TEXT , $plotColumn TEXT , $posterColumn TEXT , $imdbRatingColumn TEXT   )''');
    });
    return database;
  }

  Future<int> createNewMovie( MovieInfo  movie ) async {
    try {
      int x = await database.insert(tableName, movie.toMap());
      return x;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<MovieInfo>> getAllMovies() async {
    try {
      List<Map<String, dynamic>> results = await database.query(tableName);
      List<MovieInfo> moviesList = results.map((e) => MovieInfo.fromMap(e)).toList();

      return moviesList;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }



  deleteTask(MovieInfo movie) async {
    try {
      await database.delete(tableName, where: '$titleColumn=?', whereArgs: [movie.title]);
      return true;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
