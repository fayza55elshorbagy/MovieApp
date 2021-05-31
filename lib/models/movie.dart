class Movie{

  Movie(bool adult,String backdropPath,List<int> genreIds,id,String originalLanguage,String originalTitle,String overview,double popularity,
      String posterPath,String releaseDate,String title,bool video,double voteAverage,int voteCount){
    this.adult = adult;
    this.backdropPath = backdropPath;
    this.genreIds = genreIds;
    this.originalLanguage = originalLanguage;
    this.originalTitle = originalTitle;
    this.overview = overview;
    this.video = video;
    this.popularity = popularity;
    this.posterPath = posterPath;
    this.releaseDate = releaseDate;
    this.title = title;
    this.voteAverage = voteAverage;
    this.voteCount = voteCount;

  }
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  num popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  num voteAverage;
  int voteCount;

  Movie.oneParameterConstructor(String param){
    print(param);
  }

  Movie.fromMap(Map<String, dynamic> map){
    backdropPath = 'http://image.tmdb.org/t/p/w185/' + map["backdrop_path"];
    id = map["id"];
    overview = map["overview"];
    releaseDate = map["release_date"];
    title = map["title"];
    voteAverage = map["vote_average"];
  }

  Movie.fromDatabase(Map<String, dynamic> map){
    backdropPath = 'http://image.tmdb.org/t/p/w185/' + map["backdropPath"];
    id = map["id"];
    overview = map["overview"];
    releaseDate = map["releaseDate"];
    title = map["title"];
    voteAverage = map["voteAverage"];
  }



  Map<String,dynamic> toMap() =>{
  'backdropPath' : backdropPath,
  'id' : id,
  'overview' :overview,
  'releaseDate' : releaseDate,
  'title' : title,
  'voteAverage' : voteAverage,
  };
}

