import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/Semester.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:cgpa_calculator/pages/selection3.dart';
import 'package:flutter/material.dart';

class Selection2 extends StatefulWidget {
  final User user;
  Selection2({this.user});
  @override
  _Selection2State createState() => _Selection2State();
}

class _Selection2State extends State<Selection2> {
  List<int> levelSequenceList;
  List<Level> levels;
  int numberofLevels;
  List<int> _semesterselection;
  final _formkey = GlobalKey<FormState>();
  // List<int> property;
  // List<List<int>> _aproperty;

  @override
  void initState() {
    super.initState();
    _semesterselection = new List<int>()
      ..length = widget.user.currentlevelNumber;
    levelSequenceList =
        List<int>.generate(widget.user.currentlevelNumber, (level) => level);
    levels = widget.user.levels;
    // levels = List<Level>()..length = widget.n;
    // _aproperty = List<List<int>>()..length = widget.n;
  }

  @override
  Widget build(BuildContext context) {
    MaterialAccentColor primaryColor = Theme.of(context).primaryColor;

    numberofLevels = widget.user.currentlevelNumber;

    var levelDropDownFieldList = <Widget>[];
    levelSequenceList.forEach((level) {
      levelDropDownFieldList.add(Card(
        child: Row(
          children: <Widget>[
            Text('${level + 1}00 Level :'),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 50,
              child: DropdownButtonFormField<int>(
                value: _semesterselection[level],
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 20,
                style: TextStyle(color: Colors.grey[900]),
                validator: (value) =>
                    value == null ? 'Select number of semesters' : null,
                onChanged: (int semesterValue) {
                  setState(() {
                    _semesterselection[level] = semesterValue;

                    // property = List<int>()..length = (_selection[level] + 1);
                    // property[0] = _selection[level];
                    // _aproperty[level] = property;
                  });
                  levels[level] = Level(
                    name: '${level + 1}00 Level',
                    numberofSemesters: _semesterselection[level],
                    currentLevelNumber: widget.user.currentlevelNumber,
                    semesters: List<Semester>()
                      ..length = _semesterselection[level],
                  );
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
          Text('Select the number of semester per level',
              style: TextStyle(color: primaryColor)),
          SizedBox(height: 10),
          Form(
            key: _formkey,
            child: Column(
              children: levelDropDownFieldList,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              color: primaryColor[700],
              child: FlatButton.icon(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Selection3(
                          user: User(
                              currentlevelNumber:
                                  widget.user.currentlevelNumber,
                              name: widget.user.name,
                              school: widget.user.school,
                              levels: levels),
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
