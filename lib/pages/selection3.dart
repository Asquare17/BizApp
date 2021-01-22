import 'package:cgpa_calculator/models/Course.dart';
import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/Semester.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:cgpa_calculator/pages/selection4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Selection3 extends StatefulWidget {
  final User user;

  Selection3({this.user});
  @override
  _Selection3State createState() => _Selection3State();
}

class _Selection3State extends State<Selection3> {
  final _formkey = GlobalKey<FormState>();
  List<int> levelSequenceList;
  List<Level> levels;
  List<int> semesterSequenceList;
  List<List<int>> _semesterselection;

  List<List<Widget>> semesterDropDownFieldList;

  @override
  void initState() {
    super.initState();
    _semesterselection = new List<List<int>>()
      ..length = widget.user.currentlevelNumber;
    levelSequenceList =
        List<int>.generate(widget.user.currentlevelNumber, (level) => level);
    levels = widget.user.levels;
    semesterDropDownFieldList = List<List<Widget>>()
      ..length = widget.user.currentlevelNumber;
  }

  @override
  Widget build(BuildContext context) {
    MaterialAccentColor primaryColor = Theme.of(context).primaryColor;
    List<Widget> levelDropDownFieldList = <Widget>[];

    levelSequenceList.forEach((level) {
      int numberofSemesterperLevel = levels[level].numberofSemesters;
      semesterSequenceList =
          List<int>.generate(numberofSemesterperLevel, (semester) => semester);
      semesterDropDownFieldList[level] = <Widget>[];
      levelDropDownFieldList.add(Card(
        child: Row(
          children: <Widget>[
            Text(
              '${levels[level].name} :', //TODO
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: semesterDropDownFieldList[level],
            ),
          ],
        ),
      ));

      for (int semester in semesterSequenceList) {
        _semesterselection[level] = List<int>()
          ..length = numberofSemesterperLevel;
        semesterDropDownFieldList[level].add(Column(
          children: <Widget>[
            SizedBox(
              height: 3,
            ),
            Container(
              width: 100,
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: "Semester ${semester + 1}",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\ ]'))
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter the number of course';
                  } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                    return 'Enter a valid number';
                  } else if (int.parse(val) > 40) {
                    return 'Course is too large';
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() =>
                      _semesterselection[level][semester] = int.parse(val));
                  levels[level].semesters[semester] = Semester(
                    name: "Semester ${semester + 1}",
                    levelName: levels[level].name,
                    numberofCourse: _semesterselection[level][semester],
                    courses: List<Course>()
                      ..length = _semesterselection[level][semester],
                  );
                },
              ),
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ));
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA Calculator'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text('Select the number of course per semesters',
                style: TextStyle(color: primaryColor)),
          ),
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
                    print(_semesterselection);
                    for (Level ele in levels) {
                      for (Semester sem in ele.semesters) {
                        print(sem.numberofCourse);
                        print('lol' * 1000);
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Selection4(
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
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                label: Text(
                  'Enter Scores',
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

// MaterialPageRoute(
//                         builder: (context) => InputData(
//                           n: widget.n,
//                           data: {
//                             'pointbase': widget.data['pointbase'],
//                             'passmark': widget.data['passmark'],
//                             'level': widget.data['level'],
//                             'name': widget.data['name'],
//                             'levels': _alevel, //widget.data['levels'],
//                           },
//                         ),
//                       ),
