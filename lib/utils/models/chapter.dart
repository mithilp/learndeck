import 'package:sample/utils/models/question.dart';

class Chapter {
  final String id;
  final String title;
  final String video;
  final String summary;
  final List<Question> questions;
  const Chapter({required this.id, required this.title, required this.video, required this.summary, required this.questions});
}