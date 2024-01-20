import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Column(
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
            height: 325,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                    child: Text(title,
                        style: GoogleFonts.figtree(
                            fontSize: 30, fontWeight: FontWeight.w800))),


                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('${progress > 0 ? 'Resume' : 'Start'} Course',
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

                Row(
                  children: [
                    CircleAvatar()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
