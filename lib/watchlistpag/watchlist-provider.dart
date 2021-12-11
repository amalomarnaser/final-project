import 'package:flutter/widgets.dart';
import 'package:untitled9/helpers/db-helper.dart';
import 'package:untitled9/models/Movie.dart';
import 'package:untitled9/models/MovieInfo.dart';

class WatchList extends ChangeNotifier {
  WatchList() {
    getAllFaviroute();
  }
  List<String> genreTypes=['comedy','romance','action','adventure','documentary','short','drama'];
  String selectedGenreType= '';
  List<MovieInfo> mylist = [];
 List<MovieInfo> filteredGenreList = [];
  List<String> faviroteIds = [];

  getAllFaviroute() async {
    // ignore: avoid_print[
    this.mylist = await DbHelper.dbHelper.getAllMovies();
    notifyListeners();
  }

  addMovie(MovieInfo movie) {
    bool isfound = false;

    mylist.forEach((element) {
      if (element.title == movie.title) {
        isfound = true;
        print(isfound);
      }
    });

    if (isfound) {
      DbHelper.dbHelper
          .deleteTask(movie)
          .then((value) => print('deleted successfully'));
      getAllFaviroute();

      //mylist=mylist.where((i) => i.year!=movie.year&&i.title!=movie.title).toList();
    } else {
      DbHelper.dbHelper.createNewMovie(movie).then((value) => print(value));
      print(' ${mylist.length}');

      getAllFaviroute();
      // mylist.add(movie);
    }
    // notifyListeners();
  }

  bool checkMovie(Movie movie) {
    bool isfound = false;
    mylist.forEach((element) {
      if (element.title == movie.title && element.year == movie.year) {
        isfound = true;
      }
    });
    return isfound;
  }
  setSelectedGenre(String gstr){
    selectedGenreType=gstr;
    print(gstr);
    setFilteredArray(gstr);
    notifyListeners();

  }
  setFilteredArray(String genre){
    if(genre == genreTypes[0]){filteredGenreList=mylist.where((e) => e.genre!=null).toList();}
   filteredGenreList = mylist.where((i) => i.genre.toLowerCase().contains(selectedGenreType)).toList();
  print(filteredGenreList.toString());
  }
}

