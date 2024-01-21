import 'package:sample/utils/models/question.dart';

class Chapter {
  final String id;
  final String title;
  final String query;
  late String video;
  late String summary;
  late List<Question> questions;
  Chapter({required this.id, required this.title, required this.query});
}