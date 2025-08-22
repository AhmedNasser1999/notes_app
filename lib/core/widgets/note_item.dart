import 'package:flutter/material.dart';
import 'package:notes_app/core/widgets/note_widget.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => NoteWidget(),
        separatorBuilder: (context, index) => const SizedBox(height: 20.0),
        itemCount: 20,
      ),
    );
  }
}
