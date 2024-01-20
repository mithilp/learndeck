import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';

class CourseGenerator {
  static Course generate(String title, String author) {

    const unitTitles = [
      'Introduction',
      'Dart Basics',
      'Flutter Basics',
      'Widgets',
      'State Management',
      'Navigation',
      'Networking',
      'Testing',
      'Publishing'
    ];

    final units = unitTitles.map((title) => Unit(id:title, title: title)).toList();

    return Course(
      id: title.toLowerCase().replaceAll(' ', '_'),
        title: title, author: author, units: units);
  }
}
