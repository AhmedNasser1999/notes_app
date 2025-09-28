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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: BlocBuilder<NoteCubit, NoteState>(
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NoteEmpty) {
              return Center(
                child: Text(
                  "Notes is empty. Start creating notes!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            } else if (state is NoteSuccess) {
              return state.notes.isEmpty
                  ? Center(
                      child: Text(
                        "Notes is empty. Start creating notes!",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  : NotesList(noteEntityList: state.notes);
            } else if (state is SortNoteState) {
              return NotesList(noteEntityList: state.notes);
            } else if (state is NoteFailure) {
              return _buildErrorState(context, state.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text('Error', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
