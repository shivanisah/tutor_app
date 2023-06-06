class Enrollment{

  late final int? id;
   final int? teacher_id;
   final int? student_id;
   final String? students_name;
   final String? students_number;
   late bool confirmation;



Enrollment({
  this.id,
  this.teacher_id,
  this.student_id,
  this.students_name,
  this.students_number,
 required this.confirmation

});

factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      teacher_id: json['tutor'],
      student_id: json['student'],

      students_name: json['students_name'],
      students_number: json['students_number'],
      confirmation:json['confirmation'] as bool
    );
  }
  void setConfirmation(bool value) {
    confirmation = value;
  }

}

