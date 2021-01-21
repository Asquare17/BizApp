import 'package:cgpa_calculator/pages/selection2.dart';
import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/selection.dart';
import 'pages/inputdata.dart';

void main() {
  runApp(CupertinoStoreApp());
}

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/selection': (context) => Selection(),
        '/selection2': (context) => Selection2(),
        '/inputdata': (context) => InputData(),
      },
      home: Welcome(),
    );
  }
}
