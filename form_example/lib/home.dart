import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum PageState {
  CHOOSING_FILE,
  LOADING,
  FINISH,
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File image;
  double loadPercent = 0;
  PageState state = PageState.CHOOSING_FILE;
  String resultText = '';
  int lastTimeMs = 0;

  void _chooseFile() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void _sendFile() async {
    setState(() {
      state = PageState.LOADING;
    });
  }

  Widget _buildImage() {
    if (image != null) {
      return Image.file(
        image,
        fit: BoxFit.contain,
      );
    }
    return Text('Файл не выбран');
  }

  List<Widget> _buildImageBlock() {
    switch (state) {
      case PageState.LOADING:
        return <Widget>[
          Container(
            width: 200,
            child: LinearProgressIndicator(value: loadPercent,),
          )
        ];
      case PageState.FINISH: 
        return <Widget>[
          Text(resultText),
          RaisedButton(
            onPressed: () => setState(() {
              state = PageState.CHOOSING_FILE;
            }),
            child: Text('Повторить'),
          ),
        ];
      default: {
        return <Widget>[
          _buildImage(),
          RaisedButton(
            onPressed: _chooseFile,
            child: Text('Выбрать файл'),
          ),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(25),
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _buildImageBlock(),
              ),
            ),
            if (state == PageState.CHOOSING_FILE) RaisedButton(
              onPressed: image != null ? _sendFile : null,
              child: Text('Отправить'),
            ),
          ],
        ),
      ),
    );
  }
}
