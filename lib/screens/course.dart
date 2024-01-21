import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/chapter.dart';
import 'package:sample/screens/schedule.dart';
import 'package:sample/utils/models/course.dart';
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
                    image: NetworkImage(course.image.length > 0
                        ? course.image
                        : 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'),
                  ),
                ),
                height: 250,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 450),
                        child: Row(
                          children: [
                            Text(course.title,
                                style: GoogleFonts.figtree(
                                    fontSize: 30, fontWeight: FontWeight.w800)),
                            Container(
                              padding: EdgeInsets.only(left: 45.0),
                              child: IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Schedule()),
                                    );
                                  },
                                  icon: const Icon(Icons.calendar_today),
                              iconSize: 36,
                              color: Color(0xff009966),
                              ),
                            )
                          ],
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff009966),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                                '${course.progress > 0 ? course.progress == course.unitIds?.length ? 'Finished' : 'Resume' : 'Start'} Course',
                                style: GoogleFonts.figtree(
                                  fontSize: 18,
                                  color: Colors.white,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff009966),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                                'Add${course.added ? 'ed' : ''} to Library',
                                style: GoogleFonts.figtree(
                                  fontSize: 18,
                                  color: Colors.white,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                        const SizedBox(width: 10),
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
                    const SizedBox(height: 20),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        course.units![i].chapters?.length,
                                    itemBuilder: (context, j) {
                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: TextButton(
                                            onPressed: () async {
                                              course.units![i].chapters![j]
                                                      .questions = course.units![i].chapters![j]
                                                  .questions ??
                                                  await MongoDB.getQuestions(
                                                      course
                                                          .units![i]
                                                          .chapters![j]
                                                          .questionIds);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChapterScreen(
                                                          unit: i,
                                                          chapter: j,
                                                          chapterData: course
                                                              .units![i]
                                                              .chapters![j],
                                                        )),
                                              );
                                            },
                                            child: Text(
                                              course
                                                  .units![i].chapters![j].title,
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
