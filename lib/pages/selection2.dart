import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:cgpa_calculator/pages/selection3.dart';
import 'package:flutter/material.dart';

class Selection2 extends StatefulWidget {
  final int n;
  final Map data;
  final User user;
  Selection2({this.n, this.data, this.user});
  @override
  _Selection2State createState() => _Selection2State();
}

class _Selection2State extends State<Selection2> {
  var list;
  List<Level> _alevel;
  int n;
  List<int> _selection;
  List<int> property;
  List<List<int>> _aproperty;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selection = new List<int>()..length = widget.n;
    list = List<int>.generate(widget.n, (i) => i);
    _alevel = List<Level>()..length = widget.n;
    _aproperty = List<List<int>>()..length = widget.n;
  }

  @override
  Widget build(BuildContext context) {
    n = widget.n;

    var textFields = <Widget>[];
    list.forEach((i) {
      textFields.add(Card(
        child: Row(
          children: <Widget>[
            Text('${i + 1}00 Level:'),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              child: DropdownButtonFormField<int>(
                value: _selection[i],
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 20,
                style: TextStyle(color: Colors.grey[900]),
                validator: (value) => value == null ? '!!!' : null,
                onChanged: (int newValue) {
                  setState(() {
                    _selection[i] = newValue;
                    property = List<int>()..length = (_selection[i] + 1);
                    property[0] = _selection[i];
                    _aproperty[i] = property;
                  });
                  _alevel[i] =
                      Level(name: '${i + 1}00', property: _aproperty[i]);
                },
                items: <int>[
                  1,
                  2,
                  3,
                ].map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA Calculator'),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10),
          Center(
              child: Text('Select the number of semester per level',
                  style: TextStyle(color: Colors.blueAccent))),
          SizedBox(height: 10),
          Form(
            key: _formkey,
            child: Column(
              children: textFields,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              color: Colors.blueAccent[700],
              child: FlatButton.icon(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Selection3(
                          n: n,
                          data: {
                            'pointbase': widget.data['pointbase'],
                            'passmark': widget.data['passmark'],
                            'level': widget.data['level'],
                            'name': widget.data['name'],
                            'levels': _alevel,
                          },
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                label: Text(
                  'Select number of semesters',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
