import 'package:flutter_app/models/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  static final AppDataBase instance = AppDataBase._internalConstructor();
  Database database;

  factory AppDataBase(){
    return instance;
  }

  AppDataBase._internalConstructor(){
    print("internal const");
    getDatabasesPath().then(
          (databasePath) =>
          openDatabase(
            join(databasePath, 'photos.db'),
            onCreate: (db, version) {
              print("On Create");
              db.execute(
                'CREATE TABLE MOVIES(backdropPath TEXT ,id INTEGER PRIMARY KEY ,overview TEXT ,releaseDate TEXT ,title TEXT,voteAverage DOUBLE)',);
            },
            version: 1,
          ).then(
                (db) {
                  print(db);
              database = db;
            },),
    );
  }

  Future<int> insertMovie(Movie movie) async {
    await database.insert("MOVIES", movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Movie>> getMovies() async {
    List<Map<String, dynamic>> maps = await database.query("MOVIES");
     return List.generate(maps.length, (index) {
       return Movie.fromDatabase(maps[index]);
     });
  }


}