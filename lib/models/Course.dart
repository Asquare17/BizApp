class Course {
  String name;
  int weight;
  double score;
  int grade;
  double passmark;
  double pointbase;

  Course(
      {this.name,
      this.pointbase,
      this.score,
      this.weight,
      this.passmark,
      this.grade});

  calcgrade() {
    if (pointbase == 5.0) {
      if (score < passmark) {
        grade = 0;
      } else if (score >= passmark && score < 45) {
        grade = 1;
      } else if (score >= 45 && score < 50) {
        grade = 2;
      } else if (score >= 50 && score < 60) {
        grade = 3;
      } else if (score >= 60 && score < 70) {
        grade = 4;
      } else if (score >= 70 && score < 101) {
        grade = 5;
      } else {
        grade = 0;
      }
    } else if (pointbase == 4.0) {
      if (score < passmark) {
        grade = 0;
      } else if (score >= passmark && score < 45) {
        grade = 0;
      } else if (score >= 45 && score < 50) {
        grade = 1;
      } else if (score >= 50 && score < 60) {
        grade = 2;
      } else if (score >= 60 && score < 70) {
        grade = 3;
      } else if (score >= 70 && score < 101) {
        grade = 4;
      } else {
        grade = 0;
      }
    }
  }
}
