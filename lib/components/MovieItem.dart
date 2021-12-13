// ignore_for_file: sdk_version_ui_as_code

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/models/Movie.dart' as models;
import 'package:untitled9/models/MovieInfo.dart';
import 'package:untitled9/services/movie-service.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';



class MovieItem extends StatelessWidget {
  final models.Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[

            if (this.movie.poster != "N/A")
              Image.network(this.movie.poster, height: 100, width: 100)

          ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.movie.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(this.movie.year),
                Text(this.movie.type),
                Consumer<WatchList>(
                    builder: (context ,watchList ,child){
                      return
                        IconButton(
                            onPressed:(){

                               getMovie(movie.imdbID).then((value) => {
                                watchList.addMovie(value)
                               } );
                               ;
                            },
                            icon: watchList.checkMovie(movie)? Icon(Icons.star): Icon(Icons.star_border_sharp));

                    }
                )



              ]

          ),



        ],
      ),

      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
      decoration:
      new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Colors.white),
    );
  }
}