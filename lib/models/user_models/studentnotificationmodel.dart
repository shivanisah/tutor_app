
import 'package:intl/intl.dart';

class StudentNotification{
    
   final   int id;
   final  int? teacher_id;
   final  int? student_id;
   final  String? message;
   late DateTime? date;
   late bool? seen;
   final AssociatedTeacher? teacher;
   final AssociatedEnrollment? enrrollmentform;

   StudentNotification({
    required this.id,
    this.teacher_id,
    this.student_id,
    this.date,
    this.message,
    this.seen,
    this.teacher,
    this.enrrollmentform,
   }
   );

   factory StudentNotification.fromJson(Map<String, dynamic> json){
      final dateFormat = DateFormat('yyyy-MM-dd');

    return StudentNotification(
      id:json['id'],
      student_id: json['student_id'],
      teacher_id:json['teacher_id'],
      message: json['message'],
      date:dateFormat.parse(json['date']),
      seen:json['seen'],
      teacher:json['teacher']!=null?AssociatedTeacher.fromJson(json['teacher']):null,
      enrrollmentform: json['enrollmentform']!=null?AssociatedEnrollment.fromJson(json['enrollmentform']):null,
    );
   }
    
   
}

class AssociatedTeacher{
  final String? email;
  final String? fullName;
  String? grade;
  String? phoneNumber;
  final List<String>? subjects;

  AssociatedTeacher({
    this.email,
    this.fullName,
    this.grade,
    this.phoneNumber,
    this.subjects,
  });
  factory AssociatedTeacher.fromJson(Map<String, dynamic> json){
    
  List<String>? subjectsList;
  dynamic subjectsData = json['subjects'];
  if (subjectsData is String) {
    subjectsList = [subjectsData];
  } else if (subjectsData is List<dynamic>) {
    subjectsList = List<String>.from(subjectsData);
  }

    return AssociatedTeacher(
      email:json['email'],
      fullName: json['full_name'],
      grade: json['grade'],
      phoneNumber: json['phone_number'],
      subjects:subjectsList, 

    );
  }
}

class AssociatedEnrollment{

    String? grade;
    List<String>? subjects;
    bool? confirmation;
    bool? cancellation;

    AssociatedEnrollment({
      this.grade,
      this.subjects,
      this.confirmation,
      this.cancellation,

    });

factory AssociatedEnrollment.fromJson(Map<String,dynamic> json){
  List<String>? subjectsList;
  dynamic subjectsData = json['subjects'];
  if (subjectsData is String) {
    subjectsList = [subjectsData];
  } else if (subjectsData is List<dynamic>) {
    subjectsList = List<String>.from(subjectsData);
  }

        return AssociatedEnrollment(
          grade:json['grade'],
          subjects:subjectsList,
          confirmation: json['confirmation'],
          cancellation:json['cancellation'],
        );

    }

}