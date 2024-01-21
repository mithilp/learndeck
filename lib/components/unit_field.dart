import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/utils/models/course.dart';
import 'package:sample/utils/models/unit.dart';

class UnitField extends StatefulWidget {
  final int i;
  final Course course;
  const UnitField({super.key, required this.i, required this.course});

  @override
  State<UnitField> createState() => _UnitFieldState();
}

class _UnitFieldState extends State<UnitField> {
  TextEditingController _textController = TextEditingController();
  List<String> example_units = ['Skin Cancer', 'Breast Cancer', 'Pancreatic Cancer'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 100,
            child: TextField(
              onChanged: (text) {
                widget.course.units?[widget.i].title = text;
              },
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Unit ${widget.i+1}',
                hintText: example_units[widget.i%3],
                labelStyle: GoogleFonts.figtree(
                  fontSize: 24.0,
                  color: Color(0xff888888),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      12.0), // Adjust the radius as needed
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 14.0),
              ),
              style: GoogleFonts.figtree(fontSize: 20.0),
            ),
          ),
          SizedBox(width: 6,),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Align(
              child: TextButton(
                onPressed: () {
                  setState((){widget.course.units?.removeAt(widget.i);});
                },
                child: Icon(Icons.delete, color: Colors.white, size: 32.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
