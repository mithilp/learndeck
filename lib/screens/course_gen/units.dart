import 'package:flutter/material.dart';
import 'package:sample/utils/models/course.dart';

class UnitsPage extends StatefulWidget {
  final Course course;
  const UnitsPage({super.key, required this.course});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {

  @override
  Widget build(BuildContext context) {
    print(widget.course);
    return Column(
      children: [
        Text('Give some units for'),
      ]
    );
  }
}
