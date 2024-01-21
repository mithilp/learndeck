import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/utils/models/question.dart';

class QuizComponent extends StatefulWidget {
  final List<Question> quiz;
  const QuizComponent({super.key, required this.quiz});

  @override
  State<QuizComponent> createState() => _QuizComponentState();
}

class _QuizComponentState extends State<QuizComponent> {
  late List<int> _selected = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
  // -1 -> unmarked, 0 -> incorrect, 1 -> correct
  late List<int> _correct = [-1, -1, -1, -1, -1, -1, -1, -1, -1];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.quiz.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                surfaceTintColor: _correct[index] == 0
                    ? Colors.red
                    : _correct[index] == 1
                        ? Colors.green
                        : Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.quiz[index].text,
                        style: GoogleFonts.figtree(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.quiz[index].choices.length,
                          itemBuilder: (context, j) {
                            return ListTile(
                              title: Text(
                                widget.quiz[index].choices[j],
                                style: GoogleFonts.figtree(
                                  fontSize: 18,
                                ),
                              ),
                              leading: Radio<int>(
                                value: j,
                                groupValue: _selected[index],
                                onChanged: (int? value) {
                                  setState(() {
                                    _selected[index] = value as int;
                                  });
                                },
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            List<int> colors = [];
            int correct = 0;
            for (int i = 0; i < widget.quiz.length; i++) {
              if (widget.quiz[i].answer == _selected[i]) {
                colors.add(1);
                correct++;
              } else {
                colors.add(0);
              }
            }

            setState(() {
              _correct = colors;
            });

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Quiz Results"),
                    content: Text(
                        "You got ${correct} out of ${widget.quiz.length} correct!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close"),
                      )
                    ],
                  );
                });
          },
          child: Text('Submit',
              style: GoogleFonts.figtree(
                fontSize: 18,
                color: Colors.white,
                height: 1.15,
                fontWeight: FontWeight.w800,
              )),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff009966),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
      ],
    );
  }
}
