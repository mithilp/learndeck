import 'package:auth0_flutter_platform_interface/src/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:sample/home.dart';
import 'package:sample/login.dart';

class Loading extends StatefulWidget {
  final UserProfile? user;
  Loading({super.key, UserProfile? this.user});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    print(widget.user);
    if (widget.user != null) {

      // if username not set, then go to username.dart
      // else if first time visit, then go to new.dart
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      });
    }

    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Loading...'),
        SizedBox(height: 20),
        CircularProgressIndicator(),
      ],
    );
  }
}
