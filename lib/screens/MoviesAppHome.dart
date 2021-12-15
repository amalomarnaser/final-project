// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/components/MovieItem.dart';
import 'package:untitled9/components/MovieList.dart';
import 'package:untitled9/screens/MovieDetail.dart';
import 'package:untitled9/services/movie-service.dart';
import 'package:untitled9/models/Movie.dart';
import 'package:flutter/services.dart';
import 'package:untitled9/watchlistpag/favoritemovies.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';
import 'dart:io';



class MoviesAppHome extends StatefulWidget {
  @override
  MoviesAppHomeState createState() => MoviesAppHomeState();

}

class MoviesAppHomeState extends State<MoviesAppHome> {
  final searchTextController = new TextEditingController();
  String searchText = "";
  //TextEditingController TextController= TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void itemClick(Movie item) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movieName: item.title, imdbId: item.imdbID,)),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Search Movies *_*')),
      ),
      body: SafeArea(
        top: false,
        child: Column(
        children: <Widget>[

          Container(
            child: Row(children: <Widget>[
              Column(children: [
                Icon(Icons.movie_filter_outlined )
              ],),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(

                    // Icon(Icons.movie_filter_outlined),
                    controller: searchTextController,
                    decoration: InputDecoration(hintText: 'Enter a search term please *_*'),
                  ),
                ),
              ),
              IconButton(

                icon: Icon(Icons.search),
                tooltip: 'Search Movies',
                onPressed: () {
                  // Image.asset('assets/image/a.png');
                  setState(() {

                    searchText = searchTextController.text;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  });
                },),

              //  Image.asset('assets/image/a.png'),


            ]),

            padding: EdgeInsets.all(10),
          ),
          // Image.asset('assets/image/a.png'),
          //رييييم الصورة
         (searchText.length > 0)?
            FutureBuilder<List<Movie>>(
                future: searchMovies(searchText),//list of movies
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: MovieList(movies: snapshot.data, itemClick: this.itemClick));
                  } else if (snapshot.hasError) {
                    return
                      Text('${snapshot.error.toString()}');
                  }
                  return CircularProgressIndicator();
                }):Container(child: Text("welcome to movie app"),),

          //
          //         Expanded(child:Column(children: [
          //         Image.asset('assets/image/a.png'),
          //
          // ],)
          //         )
        ],
      ),),
      drawer: Drawer(
          child :Container(
            color: Color(0xffe0ebeb),
            child: ListView(
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color:Color(0xff000000),

                    ),
                    child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Row(
                            children: [

                              Text("welcome back omar ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.white ),),
                            ],
                          ),
                        ]
                    )
                ),
                ListTile(
                    leading: Icon(Icons.favorite ,color: Colors.red,),
                    title: Text("My Favorite Movies  ",style: TextStyle(fontSize: 15,color: Colors.brown ),),

                    onTap:(){

                      Navigator.push(context ,
                          MaterialPageRoute(builder: (context)=> FavoritePage())
                      );
                    }
                ),

              ],
            ),
          )




      ),
    );
  }
}