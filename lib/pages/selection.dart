import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/School.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:cgpa_calculator/pages/selection2.dart';
import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  double pointbase = 5.0;
  double passmark = 40;
  int level = 100;

  final guestNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    guestNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaterialAccentColor primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          title: Text('CGPA Calculator'),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Card(
                child: Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: guestNameController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Enter your name!!';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Select the option that fits your school',
                style: TextStyle(color: primaryColor, fontSize: 20),
              ),
              SizedBox(height: 10),
              Card(
                child: Row(
                  children: <Widget>[
                    Text('Grading System:'),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<double>(
                      value: pointbase,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 20,
                      style: TextStyle(color: Colors.grey[900]),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (double newValue) {
                        setState(() {
                          pointbase = newValue;
                        });
                      },
                      items: <double>[
                        5.0,
                        4.0,
                      ].map<DropdownMenuItem<double>>((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                child: Row(
                  children: <Widget>[
                    Text('PassMark:'),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<double>(
                      value: passmark,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 20,
                      style: TextStyle(color: Colors.grey[900]),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (double newValue) {
                        setState(() {
                          passmark = newValue;
                        });
                      },
                      items: <double>[
                        40,
                        45,
                      ].map<DropdownMenuItem<double>>((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Text('Level:'),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<int>(
                      value: level,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 20,
                      style: TextStyle(color: Colors.grey[900]),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (int newValue) {
                        setState(() {
                          level = newValue;
                        });
                      },
                      items: <int>[100, 200, 300, 400, 500, 600]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  color: Colors.blueAccent[700],
                  child: FlatButton.icon(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Selection2(
                              n: (level * 0.01).toInt(),
                              data: {
                                'pointbase': pointbase,
                                'passmark': passmark,
                                'level': level,
                                'name': guestNameController.text,
                              },
                              user: User(
                                name: guestNameController.text,
                                school: School(
                                  pointbase: pointbase,
                                  passmark: passmark,
                                ),
                                levelNumber: (level * 0.01).toInt(),
                              ),
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
        ));
  }
}
