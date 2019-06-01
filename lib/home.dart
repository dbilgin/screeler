import 'package:flutter/material.dart';
import 'package:shake_event/shake_event.dart';
import 'package:screeler/helpers/styles.dart';

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
    with ShakeHandler {
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

    return Center(
      child: Column(
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
      ),
    );
  }
}
