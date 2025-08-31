import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/notes_list.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';

class NotesBody extends StatelessWidget {
  const NotesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteEmpty) {
              return const Center(child: Text('No notes yet.'));
            } else if (state is GetAllNotesState) {
              final notes = state.notes;
              return NotesList(onTap: () {}, noteEntity: notes);
            } else if (state is NoteError) {
              final message = state.message;
              return Center(child: Text(message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
