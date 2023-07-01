class TeacherProfile {
  final int id;
  final String? teaching_location;
  final String? teaching_experience;
  final String? education;
  final String? className;
  final List<String>? subjects;

  TeacherProfile({
    required this.id,
    this.teaching_location,
    this.teaching_experience,
    this.education,
    this.className,
    this.subjects
  });
}