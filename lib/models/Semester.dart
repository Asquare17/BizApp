import 'package:cgpa_calculator/models/Course.dart';

class Semester {
  String name;
  String levelName;
  List<Course> courses;
  int numberofCourse;
  Semester({this.courses, this.levelName, this.name, this.numberofCourse});
}
