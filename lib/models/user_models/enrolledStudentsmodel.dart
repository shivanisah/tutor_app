import 'package:intl/intl.dart';
class Enrollment{

  late final int? id;
   final int? teacher_id;
   final int? student_id;
   final String? students_name;
   final String? students_number;
   final String? parents_name;
   final String? parents_number;
   final String? address;
   final String? gender;
   final String? grade;
   late bool confirmation;
   late bool cancellation;
   final DateTime? dateJoined;
   final DateTime? time;
   late String? confirmedDate;
   late String? cancelledDate;
   final String? students_email;
   final String? tuition_joining_date;
   final String? requested_teaching_time;
   final String? startTime;
   final String? endTime;
   late final String? finishedTeachingDate;



Enrollment({
  this.id,
  this.teacher_id,
  this.student_id,
  this.students_name,
 this.students_number,
 this.parents_name,
 this.parents_number,
 this.address,
 this.gender,
 this.grade,
 required this.confirmation,
 required this.cancellation,
 this.dateJoined,
 this.time,
 this.confirmedDate,
 this.cancelledDate,
 this.students_email,
 this.tuition_joining_date,
 this.requested_teaching_time,
 this.startTime,
 this.endTime,
 this.finishedTeachingDate,


});

factory Enrollment.fromJson(Map<String, dynamic> json) {
  final dateFormat = DateFormat('yyyy-MM-dd');
  final timeFormat = DateFormat('HH:mm:ss');
  

    return Enrollment(
      id: json['id'],
      teacher_id: json['tutor'],
      student_id: json['student'],

      students_name: json['students_name'],
      students_number: json['students_number'],
      parents_name: json['parents_name'],
      parents_number:json['parents_number'],
      address:json['address'],
      gender:json['gender'],
      grade:json['grade'],
      confirmation:json['confirmation'] as bool,
      cancellation:json['cancellation'] as bool,
      dateJoined: dateFormat.parse(json['date_joined']),
      time: timeFormat.parse(json['time']),  
      tuition_joining_date: json['selected_tuitionjoining_date'],
      requested_teaching_time: json['teaching_time'],
      startTime: json['startTime'],
      endTime:json['endTime'],
      confirmedDate: json['confirmedDate'],
      cancelledDate: json['cancelledDate']
      // students_email: json['student']("email")    
        );
  }
  void setConfirmation(bool value) {
    confirmation = value;
  }

  void setCancellation(bool value) {
    cancellation = value;
  }

  void setConfirmationDate(DateTime date){
final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    confirmedDate = dateFormat.format(date);
    print(confirmedDate);
  }

void setCancellationDate(DateTime date){
final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    confirmedDate = dateFormat.format(date);
    print(confirmedDate);
  }
void setUpdateTeachingDate(String date){
  finishedTeachingDate = date;
    print(finishedTeachingDate);
  }


}

