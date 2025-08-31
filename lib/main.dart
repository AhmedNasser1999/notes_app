import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/config/di.dart';
import 'package:notes_app/core/theme/app_theme.dart';
import 'package:notes_app/data/data_source/theme_data_source.dart';
import 'package:notes_app/domain/use_cases/add_note.dart';
import 'package:notes_app/domain/use_cases/delete_all_notes.dart';
import 'package:notes_app/domain/use_cases/delete_note_by_id.dart';
import 'package:notes_app/domain/use_cases/get_all_notes.dart';
import 'package:notes_app/domain/use_cases/get_note_by_id.dart';
import 'package:notes_app/domain/use_cases/update_note.dart';
import 'package:notes_app/presentation/view/notes_screen.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  final bool value = await ThemeDataSource.getTheme();

  runApp(
    BlocProvider(
      create: (_) => NoteCubit(
        getIt<AddNote>(),
        getIt<DeleteNoteById>(),
        getIt<GetAllNotes>(),
        getIt<GetNoteById>(),
        getIt<UpdateNote>(),
        getIt<DeleteAllNotes>(),
        isDark: value,
      )..fetchAllNotes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) {
        final cubit = context.read<NoteCubit>();
        return MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const NotesScreen(),
        );
      },
    );
  }
}
