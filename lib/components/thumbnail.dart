import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/course.dart';

class Thumbnail extends StatelessWidget {
  final String image;
  final String title;
  final int progress;
  final int totalUnits;
  final String author;
  final bool library;
  final bool large;
  const Thumbnail({super.key,required this.image, required this.title, required this.progress, required this.totalUnits, required this.author, required this.library, required this.large});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CourseScreen(image: image, title: title, progress: progress, totalUnits: totalUnits, author: author, library: library)),
        );
      },
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff009966),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  image),
            ),
            border: Border.all(
              width: 8,
              color: Color(0xff009966),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          height: large ? 275.0: 175.0,
        ),
        Container(
          height: large ? 275.0: 175.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 8,
                color: Color(0xff009966),
              ),
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.black,
                  ],
                  stops: [
                    large? 0.5 : 0.1,
                    1.0
                  ])),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
                child: Text(title,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.figtree(
                      fontSize: 26,
                      color: Colors.white,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              SizedBox(height: 5),
              Text("${progress}/${totalUnits} units • @${author}",
                  style: GoogleFonts.figtree(
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Add${library ? 'ed' :''} to Library',
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
      ]),
    );
  }
}
