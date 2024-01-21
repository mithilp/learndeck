import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/screens/login.dart';
import 'package:sample/utils/mongodb.dart';

void main() async {
  await dotenv.load();

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.connect();

  runApp(const MaterialApp(
    home: Login(),
  ));
}
