import 'package:flutter/material.dart';
import 'package:screeler/handlers/firestore.dart';
import 'package:http/http.dart' as http;
import 'package:screeler/handlers/requests.dart';
import 'handlers/styles.dart';

/// This Widget is the main application widget.
class Genres extends StatelessWidget {
  static const String _title = 'Screeler!';

  Genres() {
    print("initialized");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: GenreStatefulWidget(),
    );
  }
}

class GenreStatefulWidget extends StatefulWidget {
  GenreStatefulWidget({Key key}) : super(key: key);

  @override
  _GenreStatefulWidgetState createState() => _GenreStatefulWidgetState();
}

class _GenreStatefulWidgetState extends State<GenreStatefulWidget>
    with AutomaticKeepAliveClientMixin<GenreStatefulWidget>, Requests {
  @override
  bool get wantKeepAlive => true;

  List<dynamic> _movieGenres;
  List<dynamic> _tvGenres;

  Future getGenres() async {
    if (_movieGenres != null && _tvGenres != null) return null;

    List<dynamic> movieGenres = await getMovieGenres();
    List<dynamic> tvGenres = await getTVGenres();

    if (movieGenres == null && tvGenres == null) return null;

    print("Getting movies");
    setState(() {
      _movieGenres = movieGenres;
      _tvGenres = tvGenres;
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future _init() async {
    var userGenres = await FireStore.getUserGenres();
    if (_movieGenres == null || _tvGenres == null) getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_movieGenres?.length ?? 0, (index) {
        return Center(
          child: Text(
            _movieGenres[index]["name"],
            style: Theme.of(context).textTheme.headline,
          ),
        );
      }),
    );
  }
}
