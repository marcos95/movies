class Movies {
  List<Movie> items = List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final movie = Movie.fromJsonMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'];
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['posterPath'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'];
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }
}
