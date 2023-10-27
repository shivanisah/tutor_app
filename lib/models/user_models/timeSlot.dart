import 'package:flutter/material.dart';

class TimeSlot {
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? teacherId;
  final int? id;
  final int? studentId;
  final int? enrollmentId;

  TimeSlot({
    this.startTime,
    this.endTime,
    this.teacherId,
    this.id,
    this.studentId,
    this.enrollmentId,
  });

factory TimeSlot.fromJson(Map<String, dynamic> json) {
  return TimeSlot(
    startTime: _parseTime(json['startTime']),
    endTime: _parseTime(json['endTime']),
    teacherId: json['teacherId'],
    id: json['id'],
    studentId: json['studentId'],
    enrollmentId: json['enrollmentId'],
  );
}

 static TimeOfDay _parseTime(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
}