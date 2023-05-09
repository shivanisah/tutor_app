// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TeacherList{
  // String baseUrl = "'https://jsonplaceholder.typicode.com/todos/1'";
  String baseUrl= 'http://192.168.1.66:8000/teacher/';

  Future<List<dynamic>> getAllTeacher() async {
  try {
    final url = Uri.parse(baseUrl);  
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