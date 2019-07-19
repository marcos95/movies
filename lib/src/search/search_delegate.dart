import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selection = '';

  final movies = [
    'Interestelar',
    'Drive',
    'Prueba',
    'Origen',
    'Capital america',
    'Spiderman'
  ];
  final newMovies = ['Spiderman', 'Capital america'];

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
    final suggestList = (query.isEmpty)
        ? newMovies
        : movies
            .where(
                (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestList.length,
      itemBuilder: (c, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestList[i]),
          onTap: () {
            selection = suggestList[i];
            showResults(context);
          },
        );
      },
    );
  }
}
