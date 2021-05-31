class Genres
{
  int id;
  String name;

  Genres(int id,String name){
    this.id = id;
    this.name = name;

  }
  Genres.oneParameterConstructor(String param){
    print(param);
  }
  Genres.fromMap(Map<String, dynamic> map){
    id = map["id"];
    name = map["name"];


  }
}