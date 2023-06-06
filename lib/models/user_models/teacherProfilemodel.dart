class TeacherProfile {
  final int id;
  final String teachingLocation;
  final String teachingExperience;
  final String education;
  final String className;
  final List<String> subjects;

  TeacherProfile({
    required this.id,
    required this.teachingLocation,
    required this.teachingExperience,
    required this.education,
    required this.className,
    required this.subjects
  });
}