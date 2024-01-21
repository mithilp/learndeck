import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/components/navbar.dart';
import 'package:sample/screens/course_gen/units.dart';
import 'package:sample/utils/course_generator.dart';
import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/mongodb.dart';

class TitleScreen extends StatelessWidget {
  final User user;
  final bool firstTime;

  TitleScreen({super.key, required this.user, required this.firstTime});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: firstTime
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(user: user, index: 0)),
                  );
                },
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: const Icon(Icons.close, size: 40.0),
              ),
            ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'What we learning?',
              style: GoogleFonts.figtree(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
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
                      borderRadius: BorderRadius.circular(
                          100.0), // Adjust the radius as needed
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                  ),
                  style: GoogleFonts.figtree(fontSize: 20.0),
                )),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                MongoDB.addCompleted(user.email);
                // create units page
                var course = CourseGenerator.generate(
                    _textController.text, user.username);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UnitsPage(course: course, user: user)),
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
            ),
            const SizedBox(
              height: 20,
            ),
            firstTime
                ? TextButton(
                    onPressed: () {
                      MongoDB.addCompleted(user.email);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBar(user: user, index: 0)));
                    },
                    child: const Text(
                        "I'll create my own course later, just looking around!"))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
