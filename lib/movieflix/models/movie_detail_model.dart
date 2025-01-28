class MovieDetailModel {
  final String title, overview;
  final int runtime;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        runtime = json['runtime'],
        genres = json['genres'];
}
