// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../app_urls/app_urls.dart';

class TeacherList{
  // String baseUrl = "'https://jsonplaceholder.typicode.com/todos/1'";
  // String baseUrl= 'http://192.168.43.147:8000/teacher/';

  Future<List<dynamic>> getAllTeacher() async {
  try {
    final url = Uri.parse(AppUrl.teacherlists);  
    var response = await http.get(url); 
    if (response.statusCode == 200) {
      print(response.body);

      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch teachers. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch teachers. Error: $e');
  }
}
}