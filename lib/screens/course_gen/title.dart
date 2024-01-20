import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/course_gen/units.dart';
import 'package:sample/utils/models/user.dart';

class TitleScreen extends StatelessWidget {
  TitleScreen({super.key, required User user, required bool firstTime});


  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("One more thing...",
              style: GoogleFonts.figtree(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text("What's your username?",
              style: GoogleFonts.figtree(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20,),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: 'Be Creative!',
                    hintText: 'CrazyTiger123',
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
                const id = "test";

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnitsPage(course: id)),
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
