import 'package:flutter/material.dart';
import 'package:notes_app/core/widgets/add_note_button.dart';
import 'package:notes_app/core/widgets/note_item.dart';
import '../../core/widgets/screen_title.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [ScreenTitle(), NoteItem()]),
        ),
      ),
      floatingActionButton: AddNoteButton(),
    );
  }
}
