import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/chapter.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/question.dart';
import 'package:sample/utils/mongodb.dart';

class CourseScreen extends StatelessWidget {
  final Course course;

  const CourseScreen({
    super.key,
    required this.course,
  });

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
                    image: NetworkImage(course.image),
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
                        child: Text(course.title,
                            style: GoogleFonts.figtree(
                                fontSize: 30, fontWeight: FontWeight.w800))),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                                '${course.progress > 0 ? course.progress == course.unitIds?.length ? 'Finished' : 'Resume' : 'Start'} Course',
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
                            child: Text(
                                'Add${course.added ? 'ed' : ''} to Library',
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
                            course.author.characters.first,
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
                              course.author,
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
                    ListView.builder(
                      padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: course.units?.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(course.units![i].title,
                                    style: GoogleFonts.figtree(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    )),
                                ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: course.units?.length,
                                    itemBuilder: (context, j) {
                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: TextButton(
                                            onPressed: () async {
                                              course.units![i].chapters![j].questions = await MongoDB.getQuestions(course.units![i].chapters![j].questionIds);


                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChapterScreen(
                                                          unit: j,
                                                          chapter: 0,
                                                          chapterData: course.units![i].chapters![j],
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              course.units![i].chapters![j]
                                                  .title,
                                              style: GoogleFonts.figtree(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )),
                                      );
                                    })
                              ],
                            ),
                          );
                        }),
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
