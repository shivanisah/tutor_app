import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_urls/app_urls.dart';
import '../models/user_models/searchmodel.dart';

Future<List<ClassSubject>> fetchClassSubjects() async {
  final response = await http.get(Uri.parse(AppUrl.classSubjectSearch));
  

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    
    return data.map((item) => ClassSubject(
      id: item['id'],
      className: item['class_name'],
      subjects: List<String>.from(item['subjects'].map((subjects) => subjects['name'])),      
        )).toList();
  } else {
    throw Exception('Failed to fetch class subjects');
  }
}
