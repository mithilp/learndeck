import 'package:sample/utils/models/unit.dart';

class Course {
  final String id;
  final String title;
  final String author;
  final String image;
  final int progress;
  final bool added;
  final List<Unit>? units;
  final List<String>? unitIds;
  const Course({
    required this.added,
    required this.image,
    required this.progress,
    required this.id,
    required this.title,
    required this.author,
    this.units,
    this.unitIds,
  });
}
