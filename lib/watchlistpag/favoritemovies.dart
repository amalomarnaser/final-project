import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/components/MovieItem.dart';
import 'package:untitled9/home/components/header_with_seachbox.dart';
import 'package:untitled9/home/components/recomend_plants.dart';
import 'package:untitled9/home/components/title_with_more_bbtn.dart';
import 'package:untitled9/home/constants.dart';
import 'package:untitled9/models/Movie.dart';
import 'package:untitled9/models/MovieInfo.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieListDisplay = Provider.of<WatchList>(context);
    final List<MovieInfo> movieList = movieListDisplay.mylist;
    Function handleclick(){
      movieListDisplay.searchActivated=true;
    }
    TextEditingController inputcont;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 30,
          centerTitle: true,
        ),
        body: Consumer<WatchList>(builder: (context, provider, x) {
          return ListView(children: [
            HeaderWithSearchBox(size:MediaQuery.of(context).size ,con:inputcont ,searchcli:handleclick()),
            Visibility(
              visible: movieListDisplay.searchActivated ,
              child: Container(
                child:  Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height*0.08,
                  margin: EdgeInsets.fromLTRB(2, 0, 2, 5),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieListDisplay.searchKeys.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color:movieListDisplay.selectetSearchKey==movieListDisplay.searchKeys[index]? Colors.black:Color(0xffc6ecc6).withOpacity(.3),
                            onPressed: ()=>{
                              //  print(movieListDisplay.genreTypes[index])
                              movieListDisplay.setSelectedSearchKey(movieListDisplay.searchKeys[index],'kill')
                            },
                            child: Text(
                              movieListDisplay.searchKeys[index],
                              style: TextStyle(color:movieListDisplay.selectetSearchKey==movieListDisplay.searchKeys[index]? Colors.white:Colors.black),
                            ),
                          ),
                        );
                      })),
                  ),
            ),
            Container(
               alignment: Alignment.center,
               height: MediaQuery.of(context).size.height*0.08,
               margin: EdgeInsets.fromLTRB(2, 0, 2, 5),
               child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                   itemCount: movieListDisplay.genreTypes.length,
                   itemBuilder: (BuildContext ctxt, int index) {
                 return Container(
                   margin: EdgeInsets.all(5),
                   child: FlatButton(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                     ),
                     color:movieListDisplay.selectedGenreType==movieListDisplay.genreTypes[index]? Colors.black:Color(0xffc6ecc6).withOpacity(.3),
                     onPressed: ()=>{
                     //  print(movieListDisplay.genreTypes[index])
                       movieListDisplay.setSelectedGenre(movieListDisplay.genreTypes[index])
                     },
                     child: Text(
                       movieListDisplay.genreTypes[index],
                       style: TextStyle(color:movieListDisplay.selectedGenreType==movieListDisplay.genreTypes[index]? Colors.white:Colors.black),
                     ),
                   ),
                 );
               })),

            Container(

                child: Container(
                    color: Colors.white38,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: (movieListDisplay.selectedGenreType=='all'? movieList.length:movieListDisplay.filteredGenreList.length),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return   RecomendPlantCard(
                              image: (movieListDisplay.selectedGenreType=='all'? movieList[index].poster:movieListDisplay.filteredGenreList[index].poster),
                              title:( movieListDisplay.selectedGenreType=='all'? movieList[index].title:movieListDisplay.filteredGenreList[index].title),
                              country: (movieListDisplay.selectedGenreType=='all'? movieList[index].genre:movieListDisplay.filteredGenreList[index].genre),
                              //price:  movieListDisplay.selectedGenreType=='all'?movieList[index].imdbRating!='N/A'?double.parse(movieList[index].imdbRating):200:movieListDisplay.filteredGenreList[index].imdbRating!='N/A'?double.parse(movieListDisplay.filteredGenreList[index].imdbRating):200,
                              price:  (movieListDisplay.selectedGenreType=='all'?movieList[index].imdbRating!='N/A'?double.parse(movieList[index].imdbRating):200:movieListDisplay.filteredGenreList[index].imdbRating!='N/A'?double.parse(movieListDisplay.filteredGenreList[index].imdbRating):200),
                              press: () {

                              },
                            );
                          }),
                    ))),

          ]);
        }));
  }
}
