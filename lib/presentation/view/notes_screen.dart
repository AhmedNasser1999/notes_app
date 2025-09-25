import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/add_note_button.dart';
import 'package:notes_app/core/widgets/app_drawer.dart';
import 'package:notes_app/core/widgets/notes_app_bar.dart';
import 'package:notes_app/presentation/view/notes_body.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCubit = context.read<NoteCubit>();
    return Scaffold(
      drawer: AppDrawer(
        changeTheme: noteCubit.changeTheme,
        deleteAllNotes: noteCubit.deleteAllnotes,
      ),
      appBar: NotesAppBar(),
      body: const NotesBody(),
      floatingActionButton: AddNoteButton(
        icon: Icons.add,
        onPressed: () => context.read<NoteCubit>().addNoteButton(context),
      ),
    );
  }
}
