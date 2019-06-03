import 'package:flutter/material.dart';
import 'package:screeler/util/firestore.dart';
import 'package:screeler/services/genre_service.dart';
import '../util/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
    with AutomaticKeepAliveClientMixin<GenreStatefulWidget>, GenreService {
  @override
  bool get wantKeepAlive => true;

  Map<String, dynamic> _userGenres;

  List<dynamic> _movieGenres;
  List<dynamic> _tvGenres;
  List<Widget> _widgetOptions = <Widget>[
    Center(
      child: CircularProgressIndicator(),
    ),
    Center(
      child: CircularProgressIndicator(),
    ),
  ];

  Widget genreButton(
      int id, String name, Map<String, dynamic> userGenres, bool isMovie) {
    var checkGenre = (userGenres == null || userGenres.length == 0)
        ? null
        : userGenres[(isMovie ? 'mov' : 'tv') + id.toString()];
    Color buttonColor =
        (checkGenre == null) ? Colors.white : Styles.randomColor();
    Color textColor = (checkGenre == null) ? Colors.black : Colors.white;
    return ButtonTheme(
        buttonColor: buttonColor,
        child: RaisedButton(
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
          onPressed: () async {
            userGenres =
                await FireStore.updateUserGenre(id, name, userGenres, isMovie);
            setState(() {
              _widgetOptions = <Widget>[
                genreGrids(_movieGenres, true),
                genreGrids(_tvGenres, false),
              ];
            });
            if (_userGenres == null) getGenres();
          },
          textColor: textColor,
          padding: const EdgeInsets.all(0.0),
          child: AutoSizeText(
            name,
            style: TextStyle(fontSize: 20),
            maxLines: 1,
          ),
        ));
  }

  Future getGenres() async {
    _userGenres = await FireStore.getUserGenres();

    List<dynamic> movieGenres = await getMovieGenres();
    List<dynamic> tvGenres = await getTVGenres();

    if (movieGenres == null && tvGenres == null) return null;

    setState(() {
      _movieGenres = movieGenres;
      _tvGenres = tvGenres;
      _widgetOptions = <Widget>[
        genreGrids(movieGenres, true),
        genreGrids(tvGenres, false),
      ];
    });
  }

  genreGrids(List<dynamic> list, bool isMovie) {
    return GridView.count(
      padding: EdgeInsets.all(0),
      crossAxisCount: 3,
      children: List.generate(list?.length ?? 0, (index) {
        return Container(
          child: genreButton(
              list[index]["id"], list[index]["name"], _userGenres, isMovie),
        );
      }),
    );
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
    if (_movieGenres == null || _tvGenres == null) getGenres();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text('Movie'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            title: Text('Series'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
