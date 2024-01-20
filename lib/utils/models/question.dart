class Question {
  final String id;
  final String text;
  final String answer;
  final String explanation;
  final List<String> choices;
  const Question({required this.id, required this.text, required this.answer, required this.explanation, required this.choices});
}