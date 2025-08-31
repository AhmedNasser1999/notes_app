import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/add_note_button.dart';
import 'package:notes_app/core/widgets/app_drawer.dart';
import 'package:notes_app/core/widgets/notes_app_bar.dart';
import 'package:notes_app/presentation/view/create_note_screen.dart';
import 'package:notes_app/presentation/view/notes_body.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'dart:developer';

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
        onPressed: () => _navigateToCreateNote(context),
      ),
    );
  }

  void _navigateToCreateNote(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateNoteScreen()),
    );
    log("Returned at: ${DateTime.now()}");
  }
}
