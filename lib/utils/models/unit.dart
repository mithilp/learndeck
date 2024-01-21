import 'package:sample/utils/models/chapter.dart';

class Unit {
  final String id;
  String title;
  late List<Chapter>? chapters;
  late List<String>? chapterIds;
  Unit({required this.id, required this.title, this.chapters, this.chapterIds});
}