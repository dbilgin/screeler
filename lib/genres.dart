import 'package:flutter/material.dart';
import 'package:screeler/helpers/firestore.dart';
import 'package:screeler/handlers/requests.dart';
import 'helpers/styles.dart';

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
  List<Widget> _widgetOptions = <Widget>[
    Center(
      child: CircularProgressIndicator(),
    ),
    Center(
      child: CircularProgressIndicator(),
    ),
  ];

  Widget genreButton(int id, String name) {
    return ButtonTheme(
        buttonColor: Colors.black,
        child: RaisedButton(
          onPressed: () {print(id);},
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 20),
            maxLines: 1,
          ),
        ));
  }

  Future getGenres() async {
    if (_movieGenres != null && _tvGenres != null) return null;

    List<dynamic> movieGenres = await getMovieGenres();
    for(dynamic movie : movieGenres)  
    List<dynamic> tvGenres = await getTVGenres();

    if (movieGenres == null && tvGenres == null) return null;

    setState(() {
      _movieGenres = movieGenres;
      _tvGenres = tvGenres;
      _widgetOptions = <Widget>[
        genreGrids(movieGenres),
        genreGrids(tvGenres),
      ];
    });
  }

  genreGrids(List<dynamic> list) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(list?.length ?? 0, (index) {
        return Container(
          child: genreButton(list[index]["id"], list[index]["name"]),
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
    var userGenres = await FireStore.getUserGenres();
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
