import 'package:intl/intl.dart';

class Student{
final int? id;
final  String? email;
final DateTime? date_joined;
String? name;
String? number;
String? parents_name;
String? parents_number;
String? gender;
late bool? block;
String? address;
String? latitude;
String? longitude;


Student({
  this.email,
  this.date_joined,
  this.id,
  this.name,
  this.number,
  this.parents_name,
  this.parents_number,
  this.gender,
  this.block,
  this.address,
  this.latitude,
  this.longitude,
});


factory Student.fromJson(Map<String,dynamic> json){
    

    final dateFormat = DateFormat('yyyy-MM-dd');

    return Student(

      id:json['id'],
      email:json['email'],
      date_joined: dateFormat.parse(json['date_joined']),
      name:json['name'],
      number:json['number'],
      parents_name: json['parents_name'],
      parents_number:json['parents_number'],
      gender:json['gender'],
      block:json['block'] as bool,
      address:json['address'],
      latitude: json['latitude'],
      longitude:json['longitude']

    );
    
}
  void setBlockedUser(bool value) {
    block= value;
  }
  void setUnBlockedUser(bool value) {
    block= value;
  }

}

