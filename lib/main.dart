import 'package:flutter/material.dart';
import 'package:untitled9/watchlistpag/watchlist-provider.dart';

import 'helpers/db-helper.dart';
import 'home/home_screen.dart';
import 'screens/MoviesAppHome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDatabase();
  runApp(ChangeNotifierProvider<WatchList>(create: (context)=> WatchList(),
    child: MaterialApp(
      title: 'Movies App +_+',
      // home:HomeScreen() ,),
      home:MoviesAppHome() ,),
  ));
}





// class MoviesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Movies App +_+',
//       home: MoviesAppHome() ,
//     );
//   }
// }