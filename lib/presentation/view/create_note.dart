import 'package:flutter/material.dart';
import 'package:notes_app/core/widgets/note_text_filed.dart';
import 'package:notes_app/core/widgets/title_text_filed.dart';

class CreateNote extends StatelessWidget {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  CreateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15.0),
              TitleTextFiled(controller: titleController),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Divider(),
              ),
              NoteTextFiled(controller: noteController),
            ],
          ),
        ),
      ),
    );
  }
}
