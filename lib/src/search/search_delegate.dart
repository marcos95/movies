import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final movieProvider = MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder<List<Movie>>(
      future: movieProvider.searchMovie(query),
      builder: (ctx, snapshot) {
        final movies = snapshot.data;

        if (snapshot.hasData) {
          return ListView(
              children: movies.map(
            (movie) {
              movie.uniqueId = 'search-${movie.id}';
              return Hero(
                child: ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalTitle),
                  onTap: () {
                    close(context, null);
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                ),
                tag: movie.uniqueId,
              );
            },
          ).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
