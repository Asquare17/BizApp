import 'package:cgpa_calculator/components/TableTextField.dart';
import 'package:cgpa_calculator/models/Course.dart';
import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/User.dart';
import 'package:flutter/material.dart';

class Selection4 extends StatefulWidget {
  final User user;
  Selection4({this.user});
  @override
  _Selection4State createState() => _Selection4State();
}

class _Selection4State extends State<Selection4>
    with SingleTickerProviderStateMixin {
  List<Level> levels;
  final _formkey = GlobalKey<FormState>();
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;
  static double passmark;
  static double pointbase;
  var levelSequenceList;
  var semesterSequenceList;
  var courseSequenceList;
  var _ascore;
  var _aweight;
  var _aname;
  var _acourse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    levels = widget.user.levels;
    levelSequenceList =
        List<int>.generate(widget.user.currentlevelNumber, (level) => level);
    _ascore = List<List<List<double>>>()
      ..length = widget.user.currentlevelNumber;
    _aname = List<List<List<String>>>()
      ..length = widget.user.currentlevelNumber;
    _aweight = List<List<List<int>>>()..length = widget.user.currentlevelNumber;
    _acourse = List<List<List<Course>>>()
      ..length = widget.user.currentlevelNumber;

    _scrollController = ScrollController();
    _tabController = TabController(length: levels.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(microseconds: 300), curve: Curves.ease);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
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

    passmark = widget.user.school.passmark;
    pointbase = widget.user.school.pointbase;
    return Scaffold(
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
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Text('Input Scores'),
              ),
              SliverToBoxAdapter(
                child: Container(
                  child: TabBar(
                    labelPadding: EdgeInsets.all(15),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _tabController,
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(),
                    labelColor: Colors.blue,
                    labelStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.black54,
                    unselectedLabelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    tabs: List.generate(levels.length,
                        (index) => Text('${levels[index].name}')),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: TabBarView(
                controller: _tabController,
                children: List.generate(
                    levels.length,
                    (index) => TableTextField(
                          user: widget.user,
                          level: index,
                        ))),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.calculate,
          color: Colors.white,
        ),
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            for (int level in levelSequenceList) {
              int numberofSemesterperLevel = levels[level].numberofSemesters;
              semesterSequenceList = List<int>.generate(
                  numberofSemesterperLevel, (semester) => semester);
              for (int semester in semesterSequenceList) {
                int numberofCoursepersemester =
                    levels[level].semesters[semester].numberofCourse;
                courseSequenceList = List<int>.generate(
                    numberofCoursepersemester, (course) => course);
                for (int course in courseSequenceList) {
                  _acourse[level][semester][course] = Course(
                    name: _aname[level][semester][course],
                    score: _ascore[level][semester][course],
                    weight: _aweight[level][semester][course],
                    passmark: passmark,
                    pointbase: pointbase,
                  );
                  Course a = _acourse[level][semester][course];
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
              name: widget.user.name,
              cgpa: newcgpa,
            );
          }
        },
      ),
    );
  }
}
