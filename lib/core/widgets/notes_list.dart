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
    return ListView.separated(
      itemBuilder: (context, index) => NoteWidget(
        onTap: () {
          context.read<NoteCubit>().modifyNote(
            noteEntityList[index].id,
            context,
          );
        },
        title: noteEntityList[index].title,
        noteContent: noteEntityList[index].content,
        // createdAt: noteEntity[index].createdAt!,
      ),
      separatorBuilder: (context, index) => SizedBox(height: 15.0),
      itemCount: noteEntityList.length,
    );
  }
}
