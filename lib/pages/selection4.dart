import 'package:cgpa_calculator/components/TableTextField.dart';
import 'package:cgpa_calculator/models/Course.dart';
import 'package:cgpa_calculator/models/Level.dart';
import 'package:flutter/material.dart';

class Selection4 extends StatefulWidget {
  final int n;
  final Map data;
  Selection4({this.n, this.data});
  @override
  _Selection4State createState() => _Selection4State();
}

class _Selection4State extends State<Selection4>
    with SingleTickerProviderStateMixin {
  List<Level> _alevel;
  final _formkey = GlobalKey<FormState>();
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;
  static double passmark;
  static double pointbase;
  var list;
  var list2;
  var list3;
  var _ascore;
  var _aweight;
  var _aname;
  var _acourse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO list = List<int>.generate(widget.n, (i) => i);
    _alevel = widget.data['levels'];
    list = List<int>.generate(widget.n, (i) => i);
    _ascore = List<List<List<double>>>()..length = widget.n;
    _aname = List<List<List<String>>>()..length = widget.n;
    _aweight = List<List<List<int>>>()..length = widget.n;
    _acourse = List<List<List<Course>>>()..length = widget.n;

    _scrollController = ScrollController();
    _tabController = TabController(length: _alevel.length, vsync: this);
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

    passmark = widget.data['passmark'];
    pointbase = widget.data['pointbase'];
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
                    tabs: List.generate(_alevel.length,
                        (index) => Text('${_alevel[index].name} LEVEL')),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            child: TabBarView(
                controller: _tabController,
                children: List.generate(
                    _alevel.length,
                    (index) => TableTextField(
                          data: widget.data,
                          i: index,
                          n: widget.n,
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
      ),
    );
  }
}
