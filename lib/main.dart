import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/screens/login.dart';
import 'package:sample/utils/models/user.dart';
import 'package:sample/utils/mongodb.dart';
import 'screens/home.dart';
import 'screens/schedule.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();

  runApp(const MaterialApp(
    home: Schedule(),
  ));
}
