import 'package:flutter/material.dart';
import 'package:shake_event/shake_event.dart';
import 'package:screeler/util/styles.dart';
import 'dart:math';
import '../services/suggestion_service.dart';

/// This Widget is the main application widget.
class Home extends StatelessWidget {
  static const String _title = 'Screeler!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomeStatefulWidget(),
    );
  }
}

class HomeStatefulWidget extends StatefulWidget {
  HomeStatefulWidget({Key key}) : super(key: key);

  @override
  _HomeStatefulWidgetState createState() => _HomeStatefulWidgetState();
}

class _HomeStatefulWidgetState extends State<HomeStatefulWidget>
    with ShakeHandler, SuggestionService {
  static var _mainText = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Shake to get a movie',
            style: Styles.mainText,
          ),
        ),
        Icon(
          Icons.screen_rotation,
          color: Colors.black,
          size: 50.0,
        ),
      ],
    ),
  );

  var _floatingButton;

  var _content = _mainText;
  bool _waitingShake = true;

  _getRecommendation() async {
    List<dynamic> suggestions;
    var rng = new Random();
    int randomNum = (1 + rng.nextInt(3 - 1));
    //get movie recommendation if the random number is 1.
    if (randomNum == 1)
      suggestions = await getMovieSuggestions();
    else
      suggestions = await getTVSuggestions();

    if (suggestions.length == 0) return;
    var suggestion = suggestions[rng.nextInt(suggestions.length)];

    setState(() {
      _content = Center(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Text(
              randomNum == 1 ? suggestion["title"] : suggestion["name"],
              style: Styles.mainText,
            ),
            Text(
              "Original Title: " + (randomNum == 1 ? suggestion["original_title"]: suggestion["original_name"]),
              style: Styles.noteText,
            ),
            Text(
              "Release Date: " + (randomNum == 1 ? suggestion["release_date"] : suggestion["first_air_date"]),
              style: Styles.noteText,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
              child: Text(
                "Overview: " + suggestion["overview"],
                style: Styles.normalText,
              ),
            ),
            Image.network(
                'https://image.tmdb.org/t/p/w400' + suggestion['poster_path']),
          ],
        ),
      );
      _floatingButton = FloatingActionButton(
        onPressed: () {
          setState(() {
            _content = _mainText;
            _waitingShake = true;
            _floatingButton = null;
          });
        },
        child: Icon(Icons.remove),
      );
    });
  }

  @override
  void dispose() {
    resetShakeListeners();
    super.dispose();
  }

  @override
  shakeEventListener() {
    if (_waitingShake) _getRecommendation();
    _waitingShake = false;
    return super.shakeEventListener();
  }

  @override
  Widget build(BuildContext context) {
    startListeningShake(20);

    return Scaffold(
      body: _content,
      floatingActionButton: _floatingButton,
    );
  }
}
