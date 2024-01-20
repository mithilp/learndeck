import 'package:auth0_flutter_platform_interface/src/user_profile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final UserProfile user;
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print(user);
    return const Placeholder();
  }
}
