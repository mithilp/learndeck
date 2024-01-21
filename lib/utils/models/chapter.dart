import 'package:sample/utils/models/question.dart';

class Chapter {
  final String id;
  final String title;
  final String? query;
  late String video;
  late String summary;
  late List<Question>? questions;
  late List<String>? questionIds;
  Chapter(
      {required this.id,
      required this.title,
      this.query,
      required this.video,
      required this.summary,
      this.questions,
      this.questionIds});
}
