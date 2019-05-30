import 'package:http/http.dart' as http;
import 'app_configuration.dart';
import 'dart:convert';

class Requests {
  Future<List<dynamic>> getMovieGenres() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/genre/movie/list?api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["genres"] as List;
  }

  Future<List<dynamic>> getTVGenres() async {
    return json.decode((await http.get(
            'https://api.themoviedb.org/3/genre/tv/list?api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body)["genres"] as List;
  }
}