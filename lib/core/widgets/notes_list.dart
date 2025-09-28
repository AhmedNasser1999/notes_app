import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/note_widget.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';

class NotesList extends StatelessWidget {
  final List<NoteEntity> noteEntityList;

  const NotesList({super.key, required this.noteEntityList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: noteEntityList.length,
        itemBuilder: (context, index) {
          // Add staggered animation effect
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            curve: Curves.easeInOut,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: 0.0),
              duration: Duration(milliseconds: 300 + (index * 50)),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, value * 20),
                  child: child,
                );
              },
              child: NoteWidget(
                onTap: () {
                  context.read<NoteCubit>().modifyNote(
                    noteEntityList[index].id,
                    context,
                  );
                },
                onDelete: () {
                  context.read<NoteCubit>().deleteNoteById(noteEntityList[index].id);
                },
                title: noteEntityList[index].title,
                noteContent: noteEntityList[index].content,
                categories: noteEntityList[index].categories,
              ),
            ),
          );
        },
      ),
    );
  }
}
