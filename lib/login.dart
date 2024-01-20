import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/home.dart';

import 'constants.dart';
import 'hero.dart';
import 'user.dart';

class Login extends StatefulWidget {
  final Auth0? auth0;
  const Login({this.auth0, final Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserProfile? _user;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  Future<void> login() async {
    try {
      var credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      user: credentials.user,
                    )));

    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .logout();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Login()));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        top: padding,
        bottom: padding,
        left: padding / 2,
        right: padding / 2,
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/logo.png'), height: 100,),
              SizedBox(height: 10),
              Text('Learndeck',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.figtree(
                    color: Color(0xff008061),
                    fontSize: 64,
                    height: 0.8,
                    fontWeight: FontWeight.w800,
                  )),
              SizedBox(height: 20),
              _user != null
                  ? ElevatedButton(
                      onPressed: logout,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      child: const Text('Logout'),
                    )
                  : ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (Color(0xff008061)),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      child: Text('Login',
                          style: GoogleFonts.figtree(
                            fontSize: 24,
                            color: Colors.white,
                            height: 0.8,
                            fontWeight: FontWeight.w800,
                          )),
                    )
            ]),
      ),
    ));
  }
}