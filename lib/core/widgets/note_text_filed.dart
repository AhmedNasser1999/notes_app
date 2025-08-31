import 'package:flutter/material.dart';

class NoteTextFiled extends StatelessWidget {
  final TextEditingController controller;
  const NoteTextFiled({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 25.0),
        minLines: 1,
        maxLines: 50,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Start typing',
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
        ),
      ),
    );
  }
}
