import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/components/navbar.dart';
import 'package:sample/components/unit_field.dart';
import 'package:sample/screens/course_gen/chapters.dart';
import 'package:sample/utils/models/course.dart';
import 'package:collection/collection.dart';
import 'package:sample/utils/models/unit.dart';
import 'package:sample/utils/models/user.dart';

class UnitsPage extends StatefulWidget {
  final Course course;
  final User user;
  const UnitsPage({super.key, required this.course, required this.user});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  addUnit() {
    setState(() {
      widget.course.units?.add(Unit(id: widget.course.title, title: ''));
    });
    print(widget.course.units);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.course);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavBar(user: widget.user, index: 0)),
            );
          },
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: const Icon(Icons.close, size: 40.0),
        ),
      ),
      body: Scaffold(
        floatingActionButton: SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff009966),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChapterGenScreen(
                          course: widget.course,
                          user: widget.user,
                        )),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text('Generate Chapters',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 100),
          Text('Add Units For',
              textAlign: TextAlign.center,
              style: GoogleFonts.figtree(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: const Color(0xff8888888),
              )),
          Text(widget.course.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.figtree(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xff009966))),
          Padding(
            padding: const EdgeInsets.fromLTRB(112.0, 12, 112, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff009966),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                addUnit();
              },
              child: Row(
                children: [
                  Text('Add Unit',
                      style: GoogleFonts.figtree(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                    weight: 3,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 595,
            alignment: Alignment.topCenter,
            child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: widget.course.units!
                    .mapIndexed(
                        (i, unit) => UnitField(i: i, course: widget.course))
                    .toList()),
          ),
        ]),
      ),
    );
  }
}
