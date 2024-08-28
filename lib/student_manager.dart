import 'dart:convert';
import 'dart:io';
import 'student.dart';
import 'subject.dart';

class StudentManager {
  List<Student> students = [];

  Future<void> loadStudents() async {
  final file = File('Student.json');
  if (await file.exists()) {
    final contents = await file.readAsString();
    try {
      // Decode the JSON and extract the 'students' list
      Map<String, dynamic> jsonMap = jsonDecode(contents);
      List<dynamic> jsonList = jsonMap['students'];

      // Convert the list of maps to a list of Student objects
      students = jsonList.map((json) => Student.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error decoding JSON: $e');
    }
  }
  }

  Future<void> saveStudents() async {
    final file = File('Student.json');
    String jsonString = jsonEncode(students.map((student) => student.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  void displayAllStudents() {
    for (var student in students) {
      print('ID: ${student.id}');
      print('Name: ${student.name}');
      for (var subject in student.subjects) {
        print('Subject: ${subject.name}, Scores: ${subject.scores}');
      }
      print('');
    }
  }

  void addStudent(Student student) {
    students.add(student);
  }

  void editStudent(String id) {
    var student = students.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception('Student not found')
    );

    // Now, you are sure that `student` is not null
    print('Editing student: ${student.name}');
    print('1. Edit name');
    print('2. Add/Update subject');
    print('3. Remove subject');
    print('Enter choice: ');
    var choice = stdin.readLineSync();

    if (choice == '1') {
      print('Enter new name: ');
      student.name = stdin.readLineSync()!;
    } else if (choice == '2') {
      print('Enter subject name: ');
      var subjectName = stdin.readLineSync()!;
      print('Enter scores (comma separated): ');
      var scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
      var subject = student.subjects.firstWhere(
        (s) => s.name == subjectName,
        orElse: () => Subject(subjectName, scores) // Provide a new Subject if not found
      );
      if (student.subjects.contains(subject)) {
        subject.scores = scores;
      } else {
        student.subjects.add(subject);
      }
    } else if (choice == '3') {
      print('Enter subject name to remove: ');
      var subjectName = stdin.readLineSync()!;
      student.subjects.removeWhere((s) => s.name == subjectName);
    } else {
      print('Invalid choice');
    }
}


  void searchStudent(String searchTerm) {
    var result = students.where((s) => s.name.contains(searchTerm) || s.id.contains(searchTerm)).toList();
    if (result.isEmpty) {
      print('No student found');
    } else {
      for (var student in result) {
        print('ID: ${student.id}');
        print('Name: ${student.name}');
        for (var subject in student.subjects) {
          print('Subject: ${subject.name}, Scores: ${subject.scores}');
        }
        print('');
      }
    }
  }
}
