import 'package:intl/intl.dart';

class Student{
final int? id;
final  String? email;
final DateTime? date_joined;

Student({
  this.email,
  this.date_joined,
  this.id,
});


factory Student.fromJson(Map<String,dynamic> json){
    

    final dateFormat = DateFormat('yyyy-MM-dd');

    return Student(

      id:json['id'],
      email:json['email'],
      date_joined: dateFormat.parse(json['date_joined'])
    );
    
}

}

