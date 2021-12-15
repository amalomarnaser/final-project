import 'package:flutter/widgets.dart';
import 'package:untitled9/helpers/db-helper.dart';
import 'package:untitled9/models/Movie.dart';
import 'package:untitled9/models/MovieInfo.dart';

class WatchList extends ChangeNotifier {
  WatchList() {
    getAllFaviroute();
  }
  List<String> genreTypes=['all','comedy','romance','action','adventure','documentary','short','drama',];
  String selectedGenreType= 'all';


  List<String> searchKeys=['title','genre','year'];
  String selectetSearchKey='title';

   bool searchActivated=false;
   bool isSearch=false;
  List<MovieInfo> mylist = [];
 List<MovieInfo> filteredGenreList = [];
 List<MovieInfo> filteredSearchList = [];
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
    if(genre == 'all'){filteredGenreList=mylist;}
   else{filteredGenreList = mylist.where((i) => i.genre.toLowerCase().contains(selectedGenreType)).toList();print(filteredGenreList.toString());}

  }
  setSelectedSearchKey(String key){
    selectetSearchKey=key;
    print(selectetSearchKey);

    notifyListeners();

  }
  setsearchActivated(){
    this.searchActivated=true;
    notifyListeners();
  }
  setsearchUnActivated(){
    this.searchActivated=false;
    notifyListeners();
  }
  filterSearchArray(String input){
    setIsSearchActive();
    setSearchFilteredArray(selectetSearchKey,input);
    setsearchUnActivated();
    notifyListeners();
  }
  setSearchFilteredArray(String key,String input){
    if(key=='title'){
      filteredSearchList = mylist.where((i) => i.title.toLowerCase().contains(input.toLowerCase())).toList();
    }
    else if(key=='genre'){
      filteredSearchList = mylist.where((i) => i.genre.toLowerCase().contains(input.toLowerCase())).toList();
    }
    else if(key=='year'){
      filteredSearchList=mylist.where((element) => element.year==input).toList();
    }



  }
  setIsSearchActive(){
    isSearch=true;
    notifyListeners();
  }
  setIsSearchunActive(){
    isSearch=false;
    notifyListeners();

  }

  deleteFilter(){
    setIsSearchunActive();
    setSelectedGenre('all');
    notifyListeners();
  }
}

