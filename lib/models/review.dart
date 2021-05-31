class Reviews
{
  String author;
  AuthorDetails author_details;
  String content;
  String created_at;
  String id;
  String updated_at;
  String url;

  Reviews(String auther,AuthorDetails author_details,String content,String created_at,String id,String updated_at,String url){
    this.author = author;
    this.author_details = author_details;
    this.content = content;
    this.created_at = created_at;
    this.id = id;
    this.updated_at = updated_at;
    this.url = url;

  }

  Reviews.oneParameterConstructor(String param){
    print(param);
  }

  Reviews.fromMap(Map<String, dynamic> map){
    author = map["author"];
    author_details = map["author_details"];
    content = map["content"];
    created_at = map["created_at;"];
    id = map["id"];
    updated_at = map["updated_at;"];
    url = map["url"];

  }
}

class AuthorDetails{
  String name;
  String username;
  dynamic avatar_path;
  dynamic rating;

  AuthorDetails(String name,String username,dynamic avatar_path,dynamic rating){
    this.name = name;
    this.avatar_path = avatar_path;
    this.rating = rating;
    this.username = username;
  }

}
