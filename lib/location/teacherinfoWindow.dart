import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeacherInfoWindow extends StatelessWidget {
  final String name;
  final String grade;
  final List<String> subjects;

  TeacherInfoWindow({
    required this.name,
    required this.grade,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text('Grade: $grade'),
            SizedBox(height: 4.0),
            Text('Subjects: ${subjects.join(", ")}'),
          ],
        ),
      ),
    );
  }
}
