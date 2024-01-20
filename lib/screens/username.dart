import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/utils/models/user.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key, required User user});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
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
                    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  ),
                ),
                style: GoogleFonts.figtree(fontSize: 20.0),

              )
            )

          ],

        ),
      ),
    );
  }
}
