import 'package:http/http.dart' as http;
import 'app_configuration.dart';

class Requests {
  Future<dynamic> getMovieGenres() async {
    return (await http.get(
            'https://api.themoviedb.org/3/genre/movie/list?api_key=' +
                (await AppConfiguration.getAppConfigs())["themoviedbkey"] +
                '&language=en-US'))
        .body;
  }
}
