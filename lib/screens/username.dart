import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/screens/course_gen/title.dart';
import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/mongodb.dart';

class UsernameScreen extends StatefulWidget {

  const UsernameScreen({super.key, required this.user});
  final User user;

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {

final TextEditingController _usernameController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    var titlePage = TitleScreen(user: widget.user, firstTime: true,);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('One more thing...',
              style: GoogleFonts.figtree(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "What's your username?",
                  hintText: 'Be creative!',
                  labelStyle: GoogleFonts.figtree(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0), // Adjust the radius as needed
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
                ),
                style: GoogleFonts.figtree(fontSize: 20.0),
              )
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed:  () async {
                await MongoDB.addUsername(widget.user.email, _usernameController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => titlePage),
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
