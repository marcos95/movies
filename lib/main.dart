import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';

void main() => runApp(MoviesApp());

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage()
      },
    );
  }
}