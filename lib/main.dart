import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/login.dart';
//import 'package:sample/app.dart';
import 'package:sample/course_gen/title.dart';

void main() async {
  await dotenv.load();

  runApp(TitlePage());
}
