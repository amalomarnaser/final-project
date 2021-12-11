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

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF0C9869),
          toolbarHeight: 30,
          centerTitle: true,
        ),
        body: Consumer<WatchList>(builder: (context, provider, x) {
          return ListView(children: [
            HeaderWithSearchBox(size:MediaQuery.of(context).size ,),
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
                     color:movieListDisplay.selectedGenreType==movieListDisplay.genreTypes[index]? kPrimaryColor:Colors.white,
                     onPressed: ()=>{
                       movieListDisplay.setSelectedGenre(movieListDisplay.genreTypes[index])
                     },
                     child: Text(
                       movieListDisplay.genreTypes[index],
                       style: TextStyle(color:movieListDisplay.selectedGenreType==movieListDisplay.genreTypes[index]? Colors.white:kPrimaryColor),
                     ),
                   ),
                 );
               })),
            // Expanded(
            //   flex: 1,
            //     child: TitleWithMoreBtn(title: "your watch List", press: () {})),
            Container(

                child: Container(
                    color: Colors.white38,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: movieListDisplay.selectedGenreType==''? movieList.length:movieListDisplay.filteredGenreList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return   RecomendPlantCard(
                              image: movieListDisplay.selectedGenreType==''? movieList[index].poster:movieListDisplay.filteredGenreList[index].poster,
                              title: movieListDisplay.selectedGenreType==''? movieList[index].title:movieListDisplay.filteredGenreList[index].title,
                              country: movieListDisplay.selectedGenreType==''? movieList[index].year:movieListDisplay.filteredGenreList[index].year,
                              price:  movieListDisplay.selectedGenreType==''?movieList[index].imdbRating!='N/A'?double.parse(movieList[index].imdbRating):200:movieListDisplay.filteredGenreList[index].imdbRating!='N/A'?double.parse(movieListDisplay.filteredGenreList[index].imdbRating):200,
                              press: () {

                              },
                            );
                          }),
                    ))),

          ]);
        }));
  }
}
