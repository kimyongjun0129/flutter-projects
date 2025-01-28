class MovieModel {
  final String title,
      thumb,
      originalLanguage,
      originalTitle,
      overview,
      releaseData;
  final int id, voteCount;
  final bool adult, video;
  final List genreIds;
  final double popularity;
  final dynamic voteAverage;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        releaseData = json['release_date'],
        id = json['id'],
        voteCount = json['vote_count'],
        adult = json['adult'],
        video = json['video'],
        genreIds = json['genre_ids'],
        popularity = json['popularity'],
        voteAverage = json['vote_average'];
}
