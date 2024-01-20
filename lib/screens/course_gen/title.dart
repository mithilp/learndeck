import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/course_gen/units.dart';
import 'package:sample/utils/course_generator.dart';
import 'package:sample/utils/models/user.dart';

class TitleScreen extends StatelessWidget {
  User user;
  TitleScreen({super.key, required User user, required bool firstTime, required this.user});



  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What we learning?",
              style: GoogleFonts.figtree(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Anything you want!',
                    hintText: 'Biology of Cancer',
                    labelStyle: GoogleFonts.figtree(
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0), // Adjust the radius as needed
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                  ),
                  style: GoogleFonts.figtree(fontSize: 20.0),
                )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed:  () async {
                // create units page
                var course = CourseGenerator.generate("Biology of Cancer", this.user.username);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnitsPage(course: course)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: (const Color(0xff008061)),
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: Text("Let's Go!",
                  style: GoogleFonts.figtree(
                    fontSize: 24,
                    color: Colors.white,
                    height: 0.8,
                    fontWeight: FontWeight.w800,
                  )),
            )

          ],

        ),
      ),
    );
  }
}