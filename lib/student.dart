import 'subject.dart';

class Student {
  String id;
  String name;
  List<Subject> subjects;

  Student(this.id, this.name, this.subjects);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    var subjectsJson = json['subjects'] as List;
    List<Subject> subjectsList = subjectsJson.map((subjectJson) => Subject.fromJson(subjectJson)).toList();
    return Student(json['id'].toString(), json['name'], subjectsList);  // Convert id to String
  }
}
