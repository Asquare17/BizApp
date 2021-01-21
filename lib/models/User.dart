import 'package:cgpa_calculator/models/Level.dart';
import 'package:cgpa_calculator/models/School.dart';

class User {
  String name;
  String email;
  School school;
  int currentlevelNumber;
  List<Level> levels;
  User(
      {this.name,
      this.email,
      this.levels,
      this.school,
      this.currentlevelNumber});
}
