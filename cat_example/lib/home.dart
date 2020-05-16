import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text;
  String imageUrl;
  void _sendRequest() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (imageUrl != null) Image.network(imageUrl),
            Text(
              text ?? 'no data yet',
              textAlign: TextAlign.center,
            ),
            RaisedButton(
              onPressed: _sendRequest,
              child: Text('send request'),
            ),
          ],
        ),
      ),
    );
  }
}
