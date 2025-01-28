import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/movieflix/models/movie_detail_model.dart';
import 'package:toonflix/movieflix/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String now = "now-playing";
  static const String come = "coming-soon";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(MovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowMovies() async {
    List<MovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(MovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComeMovies() async {
    List<MovieModel> moviesInstances = [];
    final url = Uri.parse('$baseUrl/$come');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        moviesInstances.add(MovieModel.fromJson(movie));
      }
      return moviesInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(int id) async {
    final url = Uri.parse('$baseUrl/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
