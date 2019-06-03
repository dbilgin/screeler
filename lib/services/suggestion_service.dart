import 'package:http/http.dart' as http;
import 'package:screeler/util/app_configuration.dart';
import 'dart:convert';
import '../util/firestore.dart';

class SuggestionService {
  Future<String> _getGenres(bool isMovie) async {
    Map<String, dynamic> userGenres =
        await FireStore.getUserGenres() as Map<String, dynamic>;

    String genres = "";
    if (userGenres == null || userGenres.length == 0) return genres;
    if (isMovie)
      userGenres.forEach((k, v) =>
          {if (k.substring(0, 3) == 'mov') genres += k.substring(3) + '|'});
    else
      userGenres.forEach((k, v) =>
          {if (k.substring(0, 2) == 'tv') genres += k.substring(2) + '|'});

    return (genres.length == 0) ? "" : genres.substring(0, genres.length - 1);
  }

  /// Returns movie suggestions.
  ///
  /// Returns a [List] of movie suggestions from themoviedb.
  Future<List<dynamic>> getMovieSuggestions() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/discover/movie?with_genres=' +
                await _getGenres(true) +
                '&sort_by=vote_average.desc&vote_count.gte=10&api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["results"] as List;
  }

  /// Returns movie genres.
  ///
  /// Returns a [List] of tv genres from themoviedb.
  Future<List<dynamic>> getTVSuggestions() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/discover/tv?with_genres=' +
                await _getGenres(false) +
                '&sort_by=vote_average.desc&vote_count.gte=10&api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["results"] as List;
  }
}
