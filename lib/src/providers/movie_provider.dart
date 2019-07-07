import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieProvider {
  String _apiKey = '3ac0281b5172df94c85cbadfb5dba12e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _loading = false;

  List<Movie> _popularMovies = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink =>
      _popularStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream =>
      _popularStreamController.stream;

  Future<List<Movie>> _extractMovies(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return _extractMovies(url);
  }

  Future<List<Movie>> getPopular() async {
    if (_loading) {
      return [];
    }
    _loading = true;
    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _extractMovies(url);
    _popularMovies.addAll(resp);
    popularMoviesSink(_popularMovies);

    _loading = false;
    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  void disposeStreams() {
    _popularStreamController?.close();
  }
}
