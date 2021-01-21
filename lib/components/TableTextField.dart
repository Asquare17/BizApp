import 'package:cgpa_calculator/models/Course.dart';
import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableTextField extends StatefulWidget {
  final User user;
  final int level;
  TableTextField({this.user, this.level});
  @override
  _TableTextFieldState createState() => _TableTextFieldState();
}

class _TableTextFieldState extends State<TableTextField> {
  bool changed;
  var _ascore;
  var _aweight;
  var _aname;
  var _acourse;
  List<Level> levels;
  var textFields2;
  List<Widget> courseFieldperSemester;
  var list;
  List<int> semesterSequenceList;
  List<int> courseSequenceList;
  @override
  void initState() {
    super.initState();
    courseFieldperSemester = List<Widget>();
    textFields2 = List<Widget>()
      ..length = widget.user.currentlevelNumber; //not sure
    levels = widget.user.levels;
    _ascore = List<List<double>>()..length = widget.user.currentlevelNumber;
    _aname = List<List<String>>()..length = widget.user.currentlevelNumber;
    _aweight = List<List<int>>()..length = widget.user.currentlevelNumber;
    _acourse = List<List<Course>>()..length = widget.user.currentlevelNumber;
  }

  @override
  Widget build(BuildContext context) {
    int numberofsemester = levels[widget.level].numberofSemesters;
    _ascore = List<List<double>>()..length = numberofsemester;
    _acourse = List<List<Course>>()..length = numberofsemester;
    _aweight = List<List<int>>()..length = numberofsemester;
    _aname = List<List<String>>()..length = numberofsemester;
    semesterSequenceList =
        List<int>.generate(numberofsemester, (semester) => semester);
    textFields2 = <Widget>[];

    for (int semester in semesterSequenceList) {
      int numberofcourse =
          levels[widget.level].semesters[semester].numberofCourse;
      _aname[semester] = List<String>()..length = numberofcourse;
      _aweight[semester] = List<int>()..length = numberofcourse;
      _ascore[semester] = List<double>()..length = numberofcourse;
      _acourse[semester] = List<Course>()..length = numberofcourse;

      courseSequenceList =
          List<int>.generate(numberofcourse, (course) => course);

      textFields2.add(Column(
        children: <Widget>[
          Text(
            'Semester ${(semester + 1).toString()}:',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          Column(
            children: courseFieldperSemester,
          ),
        ],
      ));
      courseFieldperSemester.add(Table(
          border: TableBorder.all(width: 1, color: Colors.grey),
          children: [
            TableRow(children: [
              Text('S/N'),
              Text('Course Code'),
              Text('Course Unit\'s'),
              Text('Score'),
            ]),
          ]));
      for (int course in courseSequenceList) {
        courseFieldperSemester.add(Table(
            border: TableBorder.all(width: 1, color: Colors.grey),
            children: [
              TableRow(children: [
                Text((course + 1).toString()),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please Enter course code';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    levels[widget.level]
                        .semesters[semester]
                        .courses[course]
                        .name = val;
                    changed = false;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp('[\\-|\\ ]'))
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    levels[widget.level]
                        .semesters[semester]
                        .courses[course]
                        .weight = int.parse(val);
                    changed = false;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    levels[widget.level]
                        .semesters[semester]
                        .courses[course]
                        .score = double.parse(val);
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

    return ListView(
      children: <Widget>[
        Column(
          children: textFields2,
        ),
      ],
    );
  }
}
