import 'package:sample/utils/models/unit.dart';

class Course {
  final String id;
  final String title;
  final String author;
  final List<Unit> units;
  const Course({required this.id, required this.title, required this.author, required this.units});
}