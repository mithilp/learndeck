import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnitField extends StatelessWidget {
  final int i;
  UnitField({super.key, required this.i});

  TextEditingController _textController = TextEditingController();
  List<String> example_units = ['Skin Cancer', 'Breast Cancer', 'Pancreatic Cancer'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        child: TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: 'Unit Name',
            hintText: example_units[i%3],
            labelStyle: GoogleFonts.figtree(
              fontSize: 24.0,
              color: Colors.black,
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
        )
      ),
    );
  }
}
