import 'package:flutter/material.dart';

class GradeSubjectsModel{

int? class_subject_id;
String? class_name;
List<String>? subject_name;


GradeSubjectsModel({
  this.class_subject_id,
  this.class_name,
  this.subject_name
});

factory GradeSubjectsModel.fromJson(Map<String,dynamic> json){

  return GradeSubjectsModel(

      class_subject_id: json['class_subject_id'],
      class_name: json['class_name'],
      subject_name: List<String>.from(json['subjects'])
  );
}


}