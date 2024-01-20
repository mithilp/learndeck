import 'package:flutter/material.dart';

class UnitsPage extends StatefulWidget {
  final String course;
  const UnitsPage({super.key, required this.course});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  @override
  Widget build(BuildContext context) {
    return const Text('hello');
  }
}
