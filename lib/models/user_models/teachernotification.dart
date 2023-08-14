
import 'package:intl/intl.dart';

class TeacherNotification{
    
   final   int id;
   final  int? teacher_id;
   final  String? message;
   late DateTime? date;
   late bool? seen;
   bool? previewCertificate;
   final AssociatedTeacher? teacher;

   TeacherNotification({
    required this.id,
    this.teacher_id,
    this.date,
    this.message,
    this.seen,
    this.previewCertificate,
    this.teacher,
    
   }
   );

   factory TeacherNotification.fromJson(Map<String, dynamic> json){
      final dateFormat = DateFormat('yyyy-MM-dd');

    return TeacherNotification(
      id:json['id'],
      teacher_id:json['teacher_id'],
      message: json['message'],
      date:dateFormat.parse(json['date']),
      seen:json['seen'],
      previewCertificate: json['previewCertificate'],
      teacher:json['teacher']!=null?AssociatedTeacher.fromJson(json['teacher']):null,
    );
   }
    
   
}

class AssociatedTeacher{
  final String? email;
    late bool? verification_status;
  late bool? preview_certificate;

  AssociatedTeacher({
    this.email,
    this.verification_status,
    this.preview_certificate,
  });
  factory AssociatedTeacher.fromJson(Map<String, dynamic> json){
    return AssociatedTeacher(
      email:json['email'],
      verification_status:json['verification_status'],
      preview_certificate: json['preview_certificate'],
    );
  }
}