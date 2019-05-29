
import 'package:http/http.dart' as http;

class Requests {

  Future<dynamic> getMovieGenres() async {
    return (await http.get('https://api.themoviedb.org/3/genre/movie/list?api_key=&language=en-US')).body;
  }

}