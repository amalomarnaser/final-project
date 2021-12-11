import 'package:flutter/cupertino.dart';

class MovieInfo {
  final String title ,year ,rating ,runtime ,genre ,director ,plot ,poster , imdbRating, metaScore ;

  MovieInfo(
      {@required this.title,@required  this.year, this.rating, this.runtime,@required  this.genre, this.director,@required  this.plot,@required  this.poster,@required  this.imdbRating,this.metaScore});

  factory MovieInfo.fromJSON(Map<String, dynamic> json) {
    return MovieInfo(
        title: json['Title'],
        year: json['Year'],
        rating: json['Rated'],
        runtime: json['Runtime'],
        genre: json['Genre'],
        director: json['Director'],
        plot: json['Plot'],
        poster: json['Poster'],
        imdbRating: json['imdbRating'],
        metaScore: json['Metascore']);
  }


  Map<String, dynamic> toMap() {
    return {
      'title':this.title,
      'year':this.year,
      'genre':this.genre,
      'plot':this.plot,
      'poster':this.poster,
      'imdbRating':this.imdbRating
      };
  }

factory MovieInfo.fromMap(Map<String, dynamic> map) {
    return MovieInfo(
      title:map['title'],
      year:map['year'],
      genre:map['genre'],
      plot:map['plot'],
      poster:map['poster'],
      imdbRating:map['imdbRating']
    );
  }


}