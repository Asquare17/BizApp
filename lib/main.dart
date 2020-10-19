import 'package:cgpa_calculator/pages/selection2.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';
import 'pages/selection.dart';
import 'pages/inputdata.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Home(),
      '/selection': (context) => Selection(),
      '/selection2': (context) => Selection2(),
      '/inputdata': (context) => InputData(),
    },
  ));
}
