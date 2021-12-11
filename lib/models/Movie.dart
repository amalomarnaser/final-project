// import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Movie {
  final String title ,year , type , poster ,imdbID;
  bool favorite=false ;

  Movie({this.title, this.year, this.type, this.poster, this.imdbID, this.favorite,});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'],
        year: json['Year'],
        type: json['Type'],
        poster: json['Poster'],
        imdbID: json['imdbID']);

  }
  factory Movie.fromMap(Map <String, dynamic> data){
    return Movie(
        title:data['title'],
        year:data['year'],
        type: data['type'],
        poster:data['poster'],
        imdbID:data['imdbID'],

    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'year': this.year,
      'type': this.type,
      'poster': this.poster,
      'imdbID':this.imdbID,

    };
  }

  /*
  *
  * Genre  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'isComplete': isComplete ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      taskName: map['taskName'],
      isComplete: map['isComplete'] == 1 ? true : false,
    );
  }*/
}