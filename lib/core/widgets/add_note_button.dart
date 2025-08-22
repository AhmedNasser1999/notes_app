import 'package:flutter/material.dart';
import 'package:notes_app/presentation/view/create_note.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
          
        backgroundColor: Colors.blueAccent,
          elevation: 0.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateNote()),
            );
          },
          child: const Icon(Icons.add,color: Colors.white,),
        ),
    );
  }
}