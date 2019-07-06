import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/movie_model.dart';

class MovieProvider {
  String _apiKey = '3ac0281b5172df94c85cbadfb5dba12e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

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

  Future<List<Movie>> getPopular() {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    return _extractMovies(url);
  }
}
