import 'package:flutter/material.dart';
import 'package:untitled9/components/MovieItem.dart';
import 'package:untitled9/models/Movie.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function itemClick;

  MovieList({this.movies, this.itemClick});

  @override
  Widget build(context) {
    return  Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: this.movies.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                  child: MovieItem(movie: this.movies[index]),
                  onTap: () => this.itemClick(this.movies[index]));
            }));
  }
}