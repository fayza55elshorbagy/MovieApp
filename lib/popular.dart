import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/movie.dart';
import 'package:flutter_app/second_page.dart';
import 'package:rating_bar/rating_bar.dart';


class Popular extends StatefulWidget {
  Popular({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Popular> {
  int _counter = 0;
  List<Movie> movies = [];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      // body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      backgroundColor: Color(0xFF131d2e),
      body: Column(
// Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //FF022F52
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: FutureBuilder<Object>(
                future: getMovies("popular"),
                builder: (context,snapshot){
                  print("connec state = "+snapshot.connectionState.toString());
                  if(snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  if(snapshot.error != null)
                    return Center(child: Text((snapshot.error as Exception).toString()));
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      print('*************');
                      print('${movies[index].backdropPath}');
                      print('*************');

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (_) => SecondPage(movie: movies[index])));
                        },
                      child :
                          ClipRRect(

                          borderRadius: BorderRadius.circular(50),

                      child: Container(
                      color : Colors.white,
                      margin: new EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                          children: [
                            Container(
                              child: Hero(
                                tag: '${movies[index].id}',
                                child: Image.network('https://image.tmdb.org/t/p/w200'+ '${movies[index].backdropPath}',
                                ),
                              ),
                            ),
                            Expanded(child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,

                                  padding: new EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Text(
                                    movies[index].title,
                                    // maxLines: 5,
                                    style:
                                    TextStyle(color: Color(0xFF131d2e), fontSize: 15,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: new EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Row(
                                    children:  [
                                      RatingBar.readOnly(
                                        size: 15,
                                        initialRating: (movies[index].voteAverage / 2),
                                        isHalfAllowed: true,
                                        halfFilledIcon: Icons.star_half,
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        alignment: Alignment.topLeft,
                                        padding:
                                        new EdgeInsets.fromLTRB(10, 8, 8, 0),
                                        child: Icon(
                                          Icons.alarm,
                                          color: Color(0xFF131d2e),
                                          size: 17,
                                        )),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding: new EdgeInsets.fromLTRB(0, 10, 10, 0),
                                      child: Text(
                                        "2h 25m",
                                        style: TextStyle(
                                            color: Color(0xFF131d2e), fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding:
                                        new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF131d2e),
                                          size: 17,
                                        )),
                                    Container(
                                      padding: new EdgeInsets.fromLTRB(2, 10, 10, 0),
                                      child: Text(
                                        movies[index].releaseDate,
                                        style: TextStyle(
                                            color: Color(0xFF131d2e), fontSize: 15),
                                      ),
                                    ),

                                  ],
                                ),
                                Container(
                                  padding: new EdgeInsets.fromLTRB(0, 5, 5, 0),
                                  height: 10,
                                  width: 50,
                                )
                              ],
                            ),),

                          ],
                        ),
                      ),
                          ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      // ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<List<Movie>> getMovies(String mode) async {
    var response = await Dio().get(
      'https://api.themoviedb.org/3/movie/$mode?api_key=f55fbda0cb73b855629e676e54ab6d8e&language=en-US&page=1',
    );
    //print(response.data);

    for (var item in response.data["results"]){
      Movie movie = Movie.fromMap(item);
      movies.add(movie);
      print(movie.title);
    }
    return  movies;

  }
}
