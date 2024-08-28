import 'dart:io';
import 'student_manager.dart';
import 'student.dart';
import 'subject.dart';

void main() async {
  var manager = StudentManager();
  await manager.loadStudents();

  while (true) {

    print('1. Display all students');
    print('2. Add student');
    print('3. Edit student');
    print('4. Search student');
    print('5. Exit');
    print('Enter choice: ');
    var choice = stdin.readLineSync();

    if (choice == '1') {
      manager.displayAllStudents();
    } else if (choice == '2') {
      print('Enter ID: ');
      var id = stdin.readLineSync()!;
      print('Enter name: ');
      var name = stdin.readLineSync()!;
      List<Subject> subjects = [];
      while (true) {
        print('Enter subject name (or type "done" to finish): ');
        var subjectName = stdin.readLineSync()!;
        if (subjectName == 'done') break;
        print('Enter scores (comma separated): ');
        var scores = stdin.readLineSync()!.split(',').map((score) => int.parse(score.trim())).toList();
        subjects.add(Subject(subjectName, scores));
      }
      manager.addStudent(Student(id, name, subjects));
      await manager.saveStudents();
    } else if (choice == '3') {
      print('Enter student ID to edit: ');
      var id = stdin.readLineSync()!;
      manager.editStudent(id);
      await manager.saveStudents();
    } else if (choice == '4') {
      print('Enter name or ID to search: ');
      var searchTerm = stdin.readLineSync()!;
      manager.searchStudent(searchTerm);
    } else if (choice == '5') {
      break;
    } else {
      print('Invalid choice');
    }
  }
}
