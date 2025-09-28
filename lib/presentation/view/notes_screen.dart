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
    final isTablet = MediaQuery.of(context).size.width > 600;
    
    return Scaffold(
      drawer: isTablet ? null : AppDrawer(
        changeTheme: noteCubit.changeTheme,
        deleteAllNotes: noteCubit.deleteAllNotes,
      ),
      appBar: NotesAppBar(),
      body: isTablet 
        ? Row(
            children: [
              SizedBox(
                width: 280,
                child: AppDrawer(
                  changeTheme: noteCubit.changeTheme,
                  deleteAllNotes: noteCubit.deleteAllNotes,
                ),
              ),
              const Expanded(child: NotesBody()),
            ],
          )
        : const NotesBody(),
      floatingActionButton: AddNoteButton(
        icon: Icons.add,
        onPressed: () => context.read<NoteCubit>().addNoteButton(context),
      ),
    );
  }
}
