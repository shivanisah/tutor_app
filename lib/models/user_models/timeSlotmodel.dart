class TimeSlot{
  final String? startTime;
  final String? endTime;
  final int? teacherId;
  final int? id;
  late bool? disable;

  TimeSlot({
    this.startTime,
    this.endTime,
    this.teacherId,
    this.id,
    this.disable
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'],
      endTime: json['endTime'],
      teacherId:json['teacherId'],
      id : json['id'],
      disable: json['disable'],
    );
  }
  void setDisable(bool value) {
    disable = value;
  }

}