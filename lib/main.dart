import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home_page.dart';

void main() => runApp(PeliculasApp());

class PeliculasApp extends StatelessWidget {
  const PeliculasApp({Key key}) : super(key: key);

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