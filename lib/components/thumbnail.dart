import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/course.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/mongodb.dart';

class Thumbnail extends StatelessWidget {
  final Course course;
  final bool large;
  const Thumbnail({super.key, required this.course, required this.large});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var units = await MongoDB.getUnits(course.id);
        course.units = units;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseScreen(
                course: course,
              ),
            ));
      },
      child: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff009966),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(course.image),
            ),
            border: Border.all(
              width: 8,
              color: const Color(0xff009966),
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          height: large ? 275.0 : 175.0,
        ),
        Container(
          height: large ? 275.0 : 175.0,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 8,
                color: const Color(0xff009966),
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
                    large ? 0.5 : 0.1,
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
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
                child: Text(course.title,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.figtree(
                      fontSize: 26,
                      color: Colors.white,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                    )),
              ),
              const SizedBox(height: 5),
              Text(
                  '${course.progress}/${course.unitIds?.length} units • @${course.author}',
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff009966),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Add${course.added ? 'ed' : ''} to Library',
                style: GoogleFonts.figtree(
                  fontSize: 18,
                  color: Colors.white,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                )),
          ),
        ),
      ]),
    );
  }
}
