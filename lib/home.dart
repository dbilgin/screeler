// Flutter code sample for material.BottomNavigationBar.1

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:shake_event/shake_event.dart';

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

class _HomeStatefulWidgetState extends State<HomeStatefulWidget> with ShakeHandler {
  _showDialog() {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Getting reccomendation..."),
    ));
  }

  @override
  void dispose() {
    resetShakeListeners();
    super.dispose();
  }

  @override
  shakeEventListener() {
    _showDialog();
    return super.shakeEventListener();
  }

  @override
  Widget build(BuildContext context) {
    startListeningShake(10);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Shake to get a movie',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
        ),
        Icon(
          Icons.screen_rotation,
          color: Colors.black,
          size: 50.0,
        ),
      ],
    );
  }
}
