import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';

class CourseGenerator {
  static Course generate(String title, String author) {

    const unitTitles = [
      "",
      "",
      ""
    ];

    final units = unitTitles.map((title) => Unit(id:title, title: title)).toList();
    return Course(
      id: title.toLowerCase().replaceAll(' ', '_'),
        title: title, author: author, units: units, added: false, image: '', progress: 1);
  }
}
