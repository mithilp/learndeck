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
      future: MongoDB.getHome(user.username),
      builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xff009966),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Course> data = snapshot.data!;
          // Use the loaded data to build your widget
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
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
                        const SizedBox(height: 20),
                        Text("Today's featured",
                            style: GoogleFonts.figtree(
                              fontSize: 34,
                              color: Colors.black,
                              height: 1.15,
                              fontWeight: FontWeight.w800,
                            )),
                        const SizedBox(height: 10),
                        Thumbnail(
                          course: data[0],
                          large: true,
                        ),
                        const SizedBox(height: 20),
                        Text('Your recent courses',
                            style: GoogleFonts.figtree(
                              fontSize: 34,
                              color: Colors.black,
                              height: 1.15,
                              fontWeight: FontWeight.w800,
                            )),
                        const SizedBox(height: 10),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length - 2,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Thumbnail(
                                  course: data[index + 2],
                                  large: false,
                                ),
                              );
                            }),
                      ]),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
