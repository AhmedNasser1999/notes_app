import 'package:flutter/material.dart';
import 'package:notes_app/core/widgets/note_widget.dart';
import 'package:notes_app/domain/entities/note_entity.dart';

class NotesList extends StatelessWidget {
  final List<NoteEntity> noteEntity;
  final VoidCallback onTap;
  const NotesList({super.key, required this.onTap, required this.noteEntity,});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => NoteWidget(
        onTap: onTap,
        title: noteEntity[index].title!,
        noteContent: noteEntity[index].content!,
        // createdAt: noteEntity[index].createdAt!,
      ),
      separatorBuilder: (context, index) => SizedBox(height: 15.0),
      itemCount: noteEntity.length,
    );
  }
}
