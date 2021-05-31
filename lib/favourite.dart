import 'package:flutter/material.dart';
import 'package:flutter_app/MoviesModel.dart';
import 'package:flutter_app/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';


class Favourite extends StatelessWidget {
  Favourite({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<MoviesModel>(context,listen: false).getMovies("now_playing");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Consumer<MoviesModel>(
        builder: (context,model, child){
          return FutureBuilder<List<Movie>>(
            future: model.getFavMovies(),
            builder: (context, snapshot) {
              print(snapshot.error);
              if(snapshot.data == null)
                {
                 return CircularProgressIndicator();
                }

              return ListView.builder(

                  itemCount: snapshot.data.length,
                  itemBuilder: (_ ,index){
                    Movie movie = model.movies[index];
                    return Container(
                      // body: Center(
                      // Center is a layout widget. It takes a single child and positions it
                      // in the middle of the parent.
                      color: Color(0xFF131d2e),
                      child: Column(
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
                          Stack(

                            children: [
                              Container(
                                child: Image.network(movie.backdropPath,
                                  width: 430.0,
                                  height: 300.0,
                                  fit: BoxFit.cover,
                                ),

                              ),
                              Container(
                                padding: new EdgeInsets.fromLTRB(0, 50, 10, 0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context,"");
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),),
                              ),
                            ],
                          ),

                          Container(
                            alignment: Alignment.topLeft,
                            padding: new EdgeInsets.fromLTRB(10, 20, 10, 20),
                            child: Text(movie.title,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 25,
                                    color: Colors.white) ),
                          ),
                          Row(
                            children:  [
                              RatingBar.readOnly(
                                initialRating: (movie.voteAverage / 2),
                                size: 15,
                                isHalfAllowed: true,
                                halfFilledIcon: Icons.star_half,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                    size: 17,
                                  )
                              ),
                              Container(
                                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Text( "2h 25m",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  child: Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 17,
                                  )
                              ),
                              Container(
                                padding: new EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Text( movie.releaseDate,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: new EdgeInsets.fromLTRB(10, 50, 10, 0),
                            child: Text(movie.overview,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                                color: Colors.white, ),
                            ),
                          )
                        ],
                      ),
                      // ),
                      // This trailing comma makes auto-formatting nicer for build methods.
                    );

                  });
            }
          );
        }
    );
  }



  }




