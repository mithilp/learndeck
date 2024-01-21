import 'package:sample/utils/models/chapter.dart';

class Unit {
  final String id;
  String title;
  late List<Chapter> chapters;
  Unit({required this.id, required this.title, chapters});
}