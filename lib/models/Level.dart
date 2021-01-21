import 'package:cgpa_calculator/models/Semester.dart';

class Level {
  String name;
  int currentLevelNumber;
  int numberofSemesters;
  List<Semester> semesters;
  // List<int> property;
  Level(
      {this.name,
      this.semesters,
      this.currentLevelNumber,
      this.numberofSemesters});
}
