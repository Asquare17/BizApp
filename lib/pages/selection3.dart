import 'package:cgpa_calculator/models/Levels.dart';
import 'package:cgpa_calculator/pages/inputdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Selection3 extends StatefulWidget {
  final int n;
  final Map data;
  Selection3({this.n, this.data});
  @override
  _Selection3State createState() => _Selection3State();
}

class _Selection3State extends State<Selection3> {
  final _formkey = GlobalKey<FormState>();
  var list;
  var list2;
  List<Level> _alevel;
  int n;

  List<int> property;

  var textFields2;

  @override
  void initState() {
    super.initState();
    list = List<int>.generate(widget.n, (i) => i);
    _alevel = widget.data['levels'];
    textFields2 = List<List<Widget>>()..length = widget.n;
  }

  @override
  Widget build(BuildContext context) {
    var textFields = <Widget>[];
    list = List<int>.generate(widget.n, (i) => i);
    list.forEach((i) {
      int b = _alevel[i].property[0];
      list2 = List<int>.generate(b, (j) => j);
      textFields2[i] = <Widget>[];
      textFields.add(Card(
        child: Row(
          children: <Widget>[
            Text(
              '${i + 1}00 Level:',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: textFields2[i],
            ),
          ],
        ),
      ));

      for (int j in list2) {
        textFields2[i].add(Column(
          children: <Widget>[
            SizedBox(
              height: 3,
            ),
            Container(
              width: 100,
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                    hintText: "Semester ${j + 1}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\ ]'))
                ],
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
                  setState(() => _alevel[i].property[j + 1] = int.parse(val));
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
                style: TextStyle(color: Colors.blueAccent)),
          ),
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
                        builder: (context) => InputData(
                          n: widget.n,
                          data: {
                            'pointbase': widget.data['pointbase'],
                            'passmark': widget.data['passmark'],
                            'level': widget.data['level'],
                            'name': widget.data['name'],
                            'levels': _alevel, //widget.data['levels'],
                          },
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
