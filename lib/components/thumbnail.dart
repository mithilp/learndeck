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
            image: course.image!= null ? DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(course.image),
            ) : DecorationImage(
              fit: BoxFit.cover,
              image: const NetworkImage('data:image/jpeg;base64,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'),
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
