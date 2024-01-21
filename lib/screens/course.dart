import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/chapter.dart';
import 'package:sample/utils/models/question.dart';

class CourseScreen extends StatelessWidget {
  final String image;
  final String title;
  final int progress;
  final int totalUnits;
  final String author;
  final bool library;
  const CourseScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.progress,
      required this.totalUnits,
      required this.author,
      required this.library});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff009966),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                ),
                height: 250,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 450),
                        child: Text(title,
                            style: GoogleFonts.figtree(
                                fontSize: 30, fontWeight: FontWeight.w800))),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                                '${progress > 0 ? progress == totalUnits ? 'Finished' : 'Resume' : 'Start'} Course',
                                style: GoogleFonts.figtree(
                                  fontSize: 18,
                                  color: Colors.white,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff009966),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Add${library ? 'ed' : ''} to Library',
                                style: GoogleFonts.figtree(
                                  fontSize: 18,
                                  color: Colors.white,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff009966),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(
                          minRadius: 30,
                          child: Text(
                            author.characters.first,
                            style: GoogleFonts.figtree(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              author,
                              style: GoogleFonts.figtree(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Author',
                              style: GoogleFonts.figtree(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Unit 1: Introduction',
                      style: GoogleFonts.figtree(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChapterScreen(
                                      video: 'QCZQCi_uKpM',
                                      unit: 0,
                                      chapter: 0,
                                      title: 'Intro',
                                      summary:
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                      quiz: [
                                        Question(
                                            id: 'test',
                                            text: "Are you gay?",
                                            answer: 0,
                                            explanation: "you're wrong ahahah",
                                            choices: ['Choice 1', 'Choice 2']),
                                        Question(
                                            id: 'test',
                                            text: "Are you gay? 2",
                                            answer: 1,
                                            explanation: "you're wrong ahahah",
                                            choices: ['2- Choice 1', '2- Choice 2']),
                                        Question(
                                            id: 'test',
                                            text: "Are you gay? 3",
                                            answer: 1,
                                            explanation: "you're wrong ahahah",
                                            choices: ['3- Choice 1', '3- Choice 2'])
                                      ],
                                    )),
                          );
                        },
                        child: Text(
                          'Chapter 1: Thing 1',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 2: Thing 2',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 3: Thing 3',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    Text(
                      'Unit 2: Stuff',
                      style: GoogleFonts.figtree(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 1: Thing 1',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 2: Thing 2',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 3: Thing 3',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    Text(
                      'Unit 3: STuffington',
                      style: GoogleFonts.figtree(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 1: Thing 1',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 2: Thing 2',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Chapter 3: Thing 3',
                          style: GoogleFonts.figtree(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
