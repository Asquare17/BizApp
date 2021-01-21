import 'package:cgpa_calculator/models/Semester.dart';

class Level {
  String name;
  int currentLevelNumber;
  List<Semester> semesters;
  List<int> property;
  Level({this.name, this.property, this.semesters, this.currentLevelNumber});
}
