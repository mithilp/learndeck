import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/course_gen/units.dart';

class TitlePage extends StatefulWidget {
  const TitlePage({super.key});

  @override
  State<TitlePage> createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height:32),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UnitsPage(course: 'hello')),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 40,
                      color: Color(0xff888888),
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (2/3)*MediaQuery.of(context).size.width,
                        child: Text(
                            'Generate Your Course',
                            style: GoogleFonts.figtree(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff00b388)
                            )
                        ),
                      ),
                      Icon(
                        Icons.square,
                        color: Color(0xff00b388),
                        size: 80
                      )
                    ]
                  ),
                ),
                SizedBox(height:100),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff888888)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff00b388))
                      ),
                      labelText: 'Course Title',
                      labelStyle: TextStyle(
                        color: Color(0xff888888),
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text(
                        'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                      )
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xff00b388)),
                    ),
                  ),
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}
