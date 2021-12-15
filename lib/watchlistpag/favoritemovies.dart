import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled9/components/MovieItem.dart';
import 'package:untitled9/home/components/header_with_seachbox.dart';
import 'package:untitled9/home/components/watch-list-item.dart';
import 'package:untitled9/home/constants.dart';
import 'package:untitled9/models/Movie.dart';
import 'package:untitled9/models/MovieInfo.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieListDisplay = Provider.of<WatchList>(context);
    final List<MovieInfo> movieList = movieListDisplay.mylist;
    TextEditingController inputcont = new TextEditingController();


   return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('my watch list'),
        ),
        body: Consumer<WatchList>(builder: (context, provider, x) {

          return ListView(children: [

           Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all( 10),

              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Container(

                    child: Expanded(
                      child: FocusScope(
                          child: Focus(

                              child: TextField(

                                  controller:inputcont ,
                                  onTap: (){
                                    movieListDisplay.setsearchActivated();
                                    },
                                  decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                  color: Color(0xFF0C9869).withOpacity(.5),
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,

                                  ),
                                  )
                                  ),
                          ),),
                  ),
                  IconButton(icon: Icon(Icons.search),
                    onPressed: (){
                      inputcont.text!=''?movieListDisplay.filterSearchArray(inputcont.text):()=>{};
                         },),
                ],
              ),
            ),

            Visibility(
              visible: movieListDisplay.searchActivated ,
              child: Container(
                child:  Container(
                  alignment: Alignment.center,
                  height: 40,
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

                              movieListDisplay.setSelectedSearchKey(movieListDisplay.searchKeys[index])
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
            Visibility(
              visible: !movieListDisplay.isSearch,
              child: Container(
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
                          color:movieListDisplay.selectedGenreType==movieListDisplay.genreTypes[index]? Colors.black:Color(0xffc6ecc6),
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
                    })),),
            Visibility(
              visible:movieListDisplay.isSearch ,
              child: Container(
              margin: EdgeInsets.all(5),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color:Color(0xffc6ecc6),
                onPressed: ()=>{
                movieListDisplay.deleteFilter()

                },
                child: Text(
                  "remove filter",
                  style: TextStyle(color:Colors.black),
                ),
              ),
            ),),

            Container(

                child: Container(
                    color: Colors.white38,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: movieListDisplay.isSearch?movieListDisplay.filteredSearchList.length:(movieListDisplay.selectedGenreType=='all'? movieList.length:movieListDisplay.filteredGenreList.length),
                          itemBuilder: (BuildContext ctxt, int index) {
                            return   WatchListItem(
                              image: movieListDisplay.isSearch?movieListDisplay.filteredSearchList[index].poster:(movieListDisplay.selectedGenreType=='all'? movieList[index].poster:movieListDisplay.filteredGenreList[index].poster),
                              title:movieListDisplay.isSearch?movieListDisplay.filteredSearchList[index].title:( movieListDisplay.selectedGenreType=='all'? movieList[index].title:movieListDisplay.filteredGenreList[index].title),
                              country: movieListDisplay.isSearch?movieListDisplay.filteredSearchList[index].genre:(movieListDisplay.selectedGenreType=='all'? movieList[index].genre:movieListDisplay.filteredGenreList[index].genre),
                              price:  movieListDisplay.isSearch?((movieListDisplay.filteredSearchList[index].imdbRating=="N/A")?200:double.parse(movieListDisplay.filteredSearchList[index].imdbRating)):(movieListDisplay.selectedGenreType=='all'?movieList[index].imdbRating!='N/A'?double.parse(movieList[index].imdbRating):200:movieListDisplay.filteredGenreList[index].imdbRating!='N/A'?double.parse(movieListDisplay.filteredGenreList[index].imdbRating):200),
                              press: () {

                              },
                            );
                          }),
                    ))),

          ]);
        }));
  }
}
