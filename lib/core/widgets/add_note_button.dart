import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const AddNoteButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        elevation: 0.0,
        onPressed: onPressed,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
