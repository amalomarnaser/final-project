import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled9/services/movie-service.dart';
import 'package:untitled9/models/MovieInfo.dart';
import 'package:untitled9/components/PaddedText.dart';

class MovieDetail extends StatelessWidget {
  final String movieName;
  final String imdbId;

  MovieDetail({this.movieName, this.imdbId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.movieName),
      ),
      body: FutureBuilder<MovieInfo>(
          future: getMovie(this.imdbId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          alignment: Alignment.center,
                          child:
                           CachedNetworkImage(
                            fit: BoxFit.fill,width:200,
                            imageUrl: snapshot.data.poster,
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.green.withOpacity(.4),),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          ),
                        Text(snapshot.data.plot, textAlign: TextAlign.justify),
                        PaddedText("Year : " + snapshot.data.year),
                        PaddedText("Genre : " + snapshot.data.genre),
                        PaddedText("Directed by : " + snapshot.data.director),
                        PaddedText("Runtime : " + snapshot.data.runtime),
                        PaddedText("Rated : " + snapshot.data.rating),
                        PaddedText("IMDB Rating : " + snapshot.data.imdbRating),
                        PaddedText("Meta Score : " + snapshot.data.metaScore),
                      ]));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error.toString()}");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}