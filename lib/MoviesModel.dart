import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/app_database.dart';
import 'package:flutter_app/models/movie.dart';

class MoviesModel extends ChangeNotifier{
  List<Movie> _movies = [];
  AppDataBase _dataBase = AppDataBase();
  MoviesModel(){
    print("movieModel");
    _dataBase.getMovies().then((movies){
      print(movies);
      _movies = movies;
      notifyListeners();
    });
  }
  get movies => _movies;

  addMovie(Movie movie) async{
    _movies.add(movie);
    await _dataBase.insertMovie(movie);
    notifyListeners();
  }

  Future<List<Movie>> getFavMovies() async{
    return _dataBase.getMovies();
  }




   getMovies(String mode) async {
    var response = await Dio().get(
      'https://api.themoviedb.org/3/movie/$mode?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
    );
    //print(response.data);

    for (var item in response.data["results"]){
      Movie movie = Movie.fromMap(item);
      _movies.add(movie);
    }
    notifyListeners();

  }
}