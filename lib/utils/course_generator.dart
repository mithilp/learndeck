import 'package:mongo_dart/mongo_dart.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';

class CourseGenerator {
  static Course generate(String title, String author) {
    const unitTitles = ['', '', ''];

    final units = unitTitles
        .map((title) => Unit(id: ObjectId().oid, title: title))
        .toList();
    return Course(
        id: ObjectId().oid,
        title: title,
        author: author,
        units: units,
        added: true,
        image: 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
        progress: 0);
  }
}
