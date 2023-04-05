class PopularPeopleModel {
  String? profilePath;
  int? id;
  String? name;
  List<DataPeople>? dataPeople;

  PopularPeopleModel({this.profilePath, this.id, this.name, this.dataPeople});

  factory PopularPeopleModel.fromJson(Map<String, dynamic> js) {
    return PopularPeopleModel(
        profilePath: js['profile_path'],
        id: js['id'],
        name: js['name'],
        dataPeople: List<DataPeople>.from(
            (js['known_for'] as List).map((e) => DataPeople.fromJson(e))));
  }
}

class DataPeople {
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

  DataPeople({
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

  factory DataPeople.fromJson(Map<String, dynamic> js) {
    return DataPeople(
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
