import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/components/unit_field.dart';
import 'package:sample/utils/models/course.dart';
import 'package:collection/collection.dart';
import 'package:sample/utils/models/unit.dart';

class UnitsPage extends StatefulWidget {
  final Course course;
  const UnitsPage({super.key, required this.course});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {

  addUnit() {
    setState(() {
      widget.course.units.add(Unit(id:widget.course.title, title: ""));
    });
    print(widget.course.units);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.course);
    return Scaffold(
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 44),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 40,
                  )
              ),
            ),
            Text(
                'Add Units For',
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                )
            ),
            Text(
                widget.course.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.figtree(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff009966)
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(112.0, 12, 112, 0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff009966),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    addUnit();
                  },
                  child: Row(
                      children: [
                          Text(
                              'Add Unit',
                              style: GoogleFonts.figtree(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                color: Colors.white
                              )
                          ),
                        Icon(
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
              height: 600,
              alignment: Alignment.topCenter,
              child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: widget.course.units.mapIndexed((i, unit) => UnitField(i: i)).toList()
              ),
            ),
          ]
        ),
      ),
      floatingActionButton: Container(
        width:300,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff009966),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () {},
          child:Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
                'Generate Chapters',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                )
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
