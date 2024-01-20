import 'package:auth0_flutter_platform_interface/src/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:sample/components/thumbnail.dart';
import 'package:sample/utils/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280,
                    child: Text('Ready to study, Mukunth?',
                        style: GoogleFonts.figtree(
                          fontSize: 34,
                          color: Colors.black,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  const Image(
                    image: AssetImage('assets/logo.png'),
                    height: 80,
                  ),
                ],
              ),
              SizedBox(height: 20),
                  Thumbnail(
                    image:
                    'https://images.ctfassets.net/1aemqu6a6t65/5ZPPRFdVSbRyZVX4XyLmHv/db575493321930ff6849c8cdd7dd2472/Chinatown-4-Manhattan-NYC-Photo-Lucia-Vazquez.jpg',
                    title: 'The History of Chinatown',
                    progress: 5,
                    totalUnits: 12,
                    author: 'mithilp',
                    library: true,
                    large: true,
                  ),
              SizedBox(height: 20),
              Text('Your recent courses',
                  style: GoogleFonts.figtree(
                    fontSize: 34,
                    color: Colors.black,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  )),
                  SizedBox(height: 10),
                  Thumbnail(
                    image:
                    'https://media.self.com/photos/5b6b0b0cbb7f036f7f5cbcfa/master/pass/apples.jpg',
                    title: 'Types of Apples',
                    progress: 6,
                    totalUnits: 6,
                    author: 'adeshmukh',
                    library: false,
                    large: false,
                  ),

            ])),
      ),
    ));
  }
}
