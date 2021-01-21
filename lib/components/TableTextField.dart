import 'package:cgpa_calculator/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableTextField extends StatefulWidget {
  final int n;
  final int i;
  final Map data;
  TableTextField({this.n, this.i, this.data});
  @override
  _TableTextFieldState createState() => _TableTextFieldState();
}

class _TableTextFieldState extends State<TableTextField> {
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
    textFields2 = List<Widget>()..length = widget.n;
    textFields3 = List<List<Widget>>()..length = widget.n; //not sure
    _alevel = widget.data['levels'];
    _ascore = List<List<double>>()..length = widget.n;
    _aname = List<List<String>>()..length = widget.n;
    _aweight = List<List<int>>()..length = widget.n;
    _acourse = List<List<Course>>()..length = widget.n;
  }

  @override
  Widget build(BuildContext context) {
    int b = _alevel[widget.i].property[0];
    textFields3 = List<List<Widget>>()..length = b;
    _ascore = List<List<double>>()..length = b;
    _acourse = List<List<Course>>()..length = b;
    _aweight = List<List<int>>()..length = b;
    _aname = List<List<String>>()..length = b;
    list2 = List<int>.generate(b, (j) => j);
    textFields2 = <Widget>[];

    for (int j in list2) {
      int c = _alevel[widget.i].property[j + 1];
      _aname[j] = List<String>()..length = c;
      _aweight[j] = List<int>()..length = c;
      _ascore[j] = List<double>()..length = c;
      _acourse[j] = List<Course>()..length = c;

      list3 = List<int>.generate(c, (j) => j);
      textFields3[j] = <Widget>[];
      textFields2.add(Column(
        children: <Widget>[
          Text(
            'Semester ${j + 1}:',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          Column(
            children: textFields3[j],
          ),
        ],
      ));
      textFields3[j].add(Table(
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
        textFields3[j].add(Table(
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
                    _aname[j][k] = val;
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
                    _aweight[j][k] = int.parse(val);
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
                    _ascore[j][k] = double.parse(val);
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
