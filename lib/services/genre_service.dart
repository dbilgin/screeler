import 'package:http/http.dart' as http;
import 'package:screeler/util/app_configuration.dart';
import 'dart:convert';

class GenreService {
  /// Returns movie genres.
  ///
  /// Returns a [List] of movie genres from themoviedb.
  Future<List<dynamic>> getMovieGenres() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/genre/movie/list?api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["genres"] as List;
  }

  /// Returns movie genres.
  ///
  /// Returns a [List] of tv genres from themoviedb.
  Future<List<dynamic>> getTVGenres() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/genre/tv/list?api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["genres"] as List;
  }
}