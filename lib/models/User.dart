import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/School.dart';

class User {
  String name;
  String email;
  School school;
  int levelNumber;
  List<Level> level;
  User({this.name, this.email, this.level, this.school, this.levelNumber});
}
