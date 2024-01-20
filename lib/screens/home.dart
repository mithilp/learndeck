import 'package:auth0_flutter_platform_interface/src/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:sample/utils/models/user.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 250,
                child: Text('Ready to study, Mukunth?',
                    style: GoogleFonts.figtree(
                  fontSize: 32,
                  color: Colors.black,
                  height: 0.8,
                  fontWeight: FontWeight.w800,
                )),
              ),
              const Image(
                image: AssetImage('assets/logo.png'),
                height: 100,
              ),
            ],
          ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff009966),
            image: const DecorationImage(
              image: NetworkImage('https://images.ctfassets.net/1aemqu6a6t65/5ZPPRFdVSbRyZVX4XyLmHv/db575493321930ff6849c8cdd7dd2472/Chinatown-4-Manhattan-NYC-Photo-Lucia-Vazquez.jpg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              width: 8,
              color:
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        )
        ]
          )
        )
    );
  }
}
