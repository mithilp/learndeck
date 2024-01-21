import 'package:flutter/material.dart';
import 'package:sample/components/thumbnail.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/utils/mongodb.dart';

class Home extends StatelessWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MongoDB.getFeatured(user.username),
      builder: (BuildContext context, AsyncSnapshot<Course> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xff009966),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          Course data = snapshot.data!;
          // Use the loaded data to build your widget
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 280,
                                  child: Text('Ready to study, ${user.username}?',
                                      style: GoogleFonts.figtree(
                                        fontSize: 34,
                                        color: Colors.black,
                                        height: 1.15,
                                        fontWeight: FontWeight.w800,
                                      )),
                                ),
                                const Image(
                                  image: AssetImage('assets/logo.png'),
                                  height: 40,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text("Today's featured",
                                style: GoogleFonts.figtree(
                                  fontSize: 34,
                                  color: Colors.black,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                            SizedBox(height: 10),
                            Thumbnail(
                              image: data.image,
                              title: data.title,
                              progress: data.progress,
                              totalUnits: data.unitIds!.length,
                              author: data.author,
                              library: data.added,
                              large: true,
                            ),
                            SizedBox(height: 20),
                            Text('Your recent courses',
                                style: GoogleFonts.figtree(
                                  fontSize: 34,
                                  color: Colors.black,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                )),
                            SizedBox(height: 10),
                            Thumbnail(
                              image:
                              'https://media.self.com/photos/5b6b0b0cbb7f036f7f5cbcfa/master/pass/apples.jpg',
                              title: 'Types of Apples',
                              progress: 6,
                              totalUnits: 6,
                              author: 'adeshmukh',
                              library: false,
                              large: false,
                            ),
                            SizedBox(height: 20),
                            Thumbnail(
                              image:
                              'https://media.self.com/photos/5b6b0b0cbb7f036f7f5cbcfa/master/pass/apples.jpg',
                              title: 'Types of Apples',
                              progress: 6,
                              totalUnits: 6,
                              author: 'adeshmukh',
                              library: false,
                              large: false,
                            ),
                          ]),
                    )),
              ),
            ),
          );
        }
      },
    );
  }
}


