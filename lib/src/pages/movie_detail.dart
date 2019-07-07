import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        body: Center(
          child: Text(movie.title),
        ),
      ),
    );
  }
}
