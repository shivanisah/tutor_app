// To parse this JSON data, do
//
//     final mapClassSubject = mapClassSubjectFromMap(jsonString);

import 'dart:convert';

MapClassSubject mapClassSubjectFromMap(String str) => MapClassSubject.fromMap(json.decode(str));

String mapClassSubjectToMap(MapClassSubject data) => json.encode(data.toMap());

class MapClassSubject {
    int teacherId;
    List<Classlist> classlist;

    MapClassSubject({
        required this.teacherId,
        required this.classlist,
    });

    factory MapClassSubject.fromMap(Map<String, dynamic> json) => MapClassSubject(
        teacherId: json["teacher_id"],
        classlist: List<Classlist>.from(json["classlist"].map((x) => Classlist.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "teacher_id": teacherId,
        "classlist": List<dynamic>.from(classlist.map((x) => x.toMap())),
    };
}

class Classlist {
    int classSubjectId;
    String className;
    List<String> subjects;

    Classlist({
        required this.classSubjectId,
        required this.className,
        required this.subjects,
    });

    factory Classlist.fromMap(Map<String, dynamic> json) => Classlist(
        classSubjectId: json["class_subject_id"],
        className: json["class_name"],
        subjects: List<String>.from(json["subjects"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "class_subject_id": classSubjectId,
        "class_name": className,
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
    };
}
