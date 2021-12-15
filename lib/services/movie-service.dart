import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:untitled9/models/Movie.dart';
import 'package:untitled9/models/MovieInfo.dart';

//const API_KEY = "<41fb8176>";
//const API_URL = "http://www.omdbapi.com/?apikey=";

Future<List<Movie>> searchMovies(String str) async {

  try {

    final result = await InternetAddress.lookup('example.com');

    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

      final response = await http.get('http://www.omdbapi.com/?s=${str}&apikey=205d8f4b');

      if (response.statusCode == 200) {

        Map data = json.decode(response.body);

        if (data['Response'] == "True") {
          var  list = (data['Search'] as List).map((item) => new Movie.fromJson(item)).toList();
          return list;
        }

        else if(response.statusCode == 503){
          throw Exception('oh no the server is down !');
        }
        else {
          throw Exception(data['Error']);
        }
      } else {
        throw Exception('Something went wrong !');
      }
    }
  }
  on SocketException catch (_) {
    throw Exception("there is no internet connection try connect to the internet and try again ");
  }

}

Future<MovieInfo> getMovie(movieId) async {


  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      final response = await http.get('http://www.omdbapi.com/?apikey=205d8f4b&i=${movieId}');
      // final response = await http.get('$API_URL$API_KEY&i=$movieId');

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);

        if (data['Response'] == "True") {
          return MovieInfo.fromJSON(data);
        } else {
          throw Exception(data['Error']);
        }
      }
      //handle server down error
      else if(response.statusCode == 503){
        throw Exception('oh no the server is down !');
      }
      else {
        throw Exception('Something went wrong !');
      }

    }
  }
  on SocketException catch (_) {
    throw Exception("there is no internet connection try connect to the internet and try again ");
  }

}