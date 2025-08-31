import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/note_text_filed.dart';
import 'package:notes_app/core/widgets/title_text_filed.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(
                  onPressed: () {
                    context.read<NoteCubit>().backToNotesScreenButton(context);
                  },
                ),
                const SizedBox(height: 15.0),
                TitleTextFiled(
                  controller: context.read<NoteCubit>().titleController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Divider(),
                ),
                NoteTextFiled(
                  controller: context.read<NoteCubit>().noteController,
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
