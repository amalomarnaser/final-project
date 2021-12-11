import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:untitled9/home/constants.dart';
import 'package:untitled9/models/MovieInfo.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';


class RecomendsPlants extends StatelessWidget {
  const RecomendsPlants({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieListDisplay = Provider.of<WatchList>(context);
    final List<MovieInfo> movieList = movieListDisplay.mylist;
    return ListView.builder(
        itemCount:  movieList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(BuildContext ctxt, int index){
         return RecomendPlantCard(
            image: "assets/images/image_1.png",
            title: "Samantha",
            country: "Russia",
            price: 440,
            press: () {

            },
          );
        });
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key key,
    this.image,
    this.title,
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, country;
  final double price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding/4,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.9,
      height: size.height*0.4,
      child: Column(
        children: <Widget>[
         //  Image.network(image,fit: BoxFit.cover,height: size.height*0.4,),
          CachedNetworkImage(
            fit: BoxFit.cover,height: size.height*0.4 ,
            imageUrl: image,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),

          GestureDetector(
            onTap: press,
            child: Container(
              width: size.width*.7,

              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(

                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),


                      ],
                    ),
                  ),

                  price==200?Text('no-rate'):Text(
                    '$price star',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
