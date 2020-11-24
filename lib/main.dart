import 'package:flutter/material.dart';
import 'package:flutter_movies/home/screen/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
