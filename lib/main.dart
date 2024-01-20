import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/login.dart';

void main() async {
  await dotenv.load();

  runApp(MaterialApp(
    home: Login(),
  ));
}
