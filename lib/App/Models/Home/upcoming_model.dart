// ignore_for_file: prefer_typing_uninitialized_variables

class UpcomingModel {
  bool? adult;
  String? backdropPath;
  List<dynamic>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  var voteAverage;
  int? voteCount;

  UpcomingModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> js) {
    return UpcomingModel(
      adult: js['adult'],
      backdropPath: js['backdrop_path'],
      genreIds: js['genre_ids'],
      id: js['id'],
      originalLanguage: js['original_language'],
      originalTitle: js['original_title'],
      overview: js['overview'],
      popularity: js['popularity'],
      posterPath: js['poster_path'],
      releaseDate: js['release_date'],
      title: js['title'],
      voteAverage: js['vote_average'],
      voteCount: js['vote_count'],
    );
  }
}
