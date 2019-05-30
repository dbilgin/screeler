import 'package:flutter/material.dart';
import 'home.dart';
import 'genres.dart';
import 'package:screeler/handlers/auth.dart';
import 'handlers/styles.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Screeler!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> with Auth {
  Home _home = new Home();
  Genres _genres = new Genres();
  List<Widget> _pages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Screeler!'),
            backgroundColor: Styles.screelerColor,
          ),
          body: TabBarView(
            children: [
              _home,
              _genres,
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Styles.screelerColor,
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.movie)),
                Tab(icon: Icon(Icons.style)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
