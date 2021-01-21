import 'package:cgpa_calculator/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputData extends StatefulWidget {
  final int n;
  final Map data;
  InputData({this.n, this.data});
  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final _formkey = GlobalKey<FormState>();
  static double passmark;
  static double pointbase;
  bool changed;
  var _ascore;
  var _aweight;
  var _aname;
  var _acourse;
  var _alevel;
  var textFields2;
  var textFields3;
  var list;
  var list2;
  var list3;
  @override
  void initState() {
    super.initState();
    textFields2 = List<List<Widget>>()..length = widget.n;
    textFields3 = List<List<List<Widget>>>()..length = widget.n; //not sure
    list = List<int>.generate(widget.n, (i) => i);
    _alevel = widget.data['levels'];
    _ascore = List<List<List<double>>>()..length = widget.n;
    _aname = List<List<List<String>>>()..length = widget.n;
    _aweight = List<List<List<int>>>()..length = widget.n;
    _acourse = List<List<List<Course>>>()..length = widget.n;
  }

  cgpaDialog({BuildContext context, double cgpa, String name}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'CGPA',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Make Changes'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).popUntil(
                    ModalRoute.withName('/selection'),
                  );
                },
              ),
            ],
            content: ListView(
              children: <Widget>[
                Text('$name your CGPA is :'),
                Text(
                  cgpa.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double cgpa;
    int weightscore;
    int totalweightscore = 0;
    int totalweight = 0;

    passmark = widget.data['passmark'];
    pointbase = widget.data['pointbase'];
    var textFields = <Widget>[];

    for (int i in list) {
      int b = _alevel[i].property[0];
      textFields3[i] = List<List<Widget>>()..length = b;
      _ascore[i] = List<List<double>>()..length = b;
      _acourse[i] = List<List<Course>>()..length = b;
      _aweight[i] = List<List<int>>()..length = b;
      _aname[i] = List<List<String>>()..length = b;
      list2 = List<int>.generate(b, (j) => j);
      textFields2[i] = <Widget>[];
      textFields.add(Card(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                '${i + 1}00 Level:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
            Column(
              children: textFields2[i],
            ),
          ],
        ),
      ));
      for (int j in list2) {
        int c = _alevel[i].property[j + 1];
        _aname[i][j] = List<String>()..length = c;
        _aweight[i][j] = List<int>()..length = c;
        _ascore[i][j] = List<double>()..length = c;
        _acourse[i][j] = List<Course>()..length = c;

        list3 = List<int>.generate(c, (j) => j);
        textFields3[i][j] = <Widget>[];
        textFields2[i].add(Column(
          children: <Widget>[
            Text(
              'Semester ${j + 1}:',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            Column(
              children: textFields3[i][j],
            ),
          ],
        ));
        textFields3[i][j].add(Table(
            border: TableBorder.all(width: 1, color: Colors.grey),
            children: [
              TableRow(children: [
                Text('S/N'),
                Text('Course Code'),
                Text('Course Unit\'s'),
                Text('Score'),
              ]),
            ]));
        for (int k in list3) {
          textFields3[i][j].add(Table(
              border: TableBorder.all(width: 1, color: Colors.grey),
              children: [
                TableRow(children: [
                  Text((k + 1).toString()),
                  TextFormField(
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Please Enter course code';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      _aname[i][j][k] = val;
                      changed = false;
                    },
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp('[\\-|\\ ]'))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter the course\'s unit';
                      } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                        return 'Enter a valid unit';
                      } else if (int.parse(val) > 20) {
                        return 'Unit is too large';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      _aweight[i][j][k] = int.parse(val);
                      changed = false;
                    },
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp('[\\-|\\ ]'))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter the course\'s score';
                      } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                        return 'Enter a valid score';
                      } else if (int.parse(val) > 100) {
                        return 'Score cannot be greater than 100';
                      } else if (int.parse(val) < 0) {
                        return 'Score cannot be negative';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      _ascore[i][j][k] = double.parse(val);
                      changed = false;
                    },
                  ),
                ]),
              ]));

          if (changed == false) {
            break;
          }
        }
        if (changed == false) {
          break;
        }
      }
      if (changed == false) {
        break;
      }
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Input your scores'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Column(
              children: textFields,
            ),
            Material(
              elevation: 5.0,
              color: Colors.blue,
              child: MaterialButton(
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    for (int i in list) {
                      int b = _alevel[i].property[0];
                      list2 = List<int>.generate(b, (j) => j);
                      for (int j in list2) {
                        int c = _alevel[i].property[j + 1];
                        list3 = List<int>.generate(c, (j) => j);
                        for (int k in list3) {
                          _acourse[i][j][k] = Course(
                            name: _aname[i][j][k],
                            score: _ascore[i][j][k],
                            weight: _aweight[i][j][k],
                            passmark: passmark,
                            pointbase: pointbase,
                          );
                          Course a = _acourse[i][j][k];
                          a.calcgrade();
                          weightscore = a.grade * a.weight;
                          totalweight = totalweight + a.weight;
                          totalweightscore = totalweightscore + weightscore;
                        }
                      }
                    }
                    cgpa = totalweightscore / totalweight;
                    double newcgpa = cgpa;
                    totalweight = 0;
                    totalweightscore = 0;
                    cgpa = 0;
                    cgpaDialog(
                      context: context,
                      name: widget.data['name'],
                      cgpa: newcgpa,
                    );
                  }
                },
                minWidth: 150.0,
                height: 30.0,
                child: Text(
                  "CALCULATE",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
