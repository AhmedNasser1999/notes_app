import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/note_text_filed.dart';
import 'package:notes_app/core/widgets/title_text_filed.dart';
import 'package:notes_app/presentation/view_model/note_cubit.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';

class CreateNoteScreen extends StatefulWidget {
  final String? noteId;

  const CreateNoteScreen({super.key, this.noteId});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen>
    with WidgetsBindingObserver {
  String? _currentNoteId;
  bool _isSaving = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentNoteId = widget.noteId;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Only save when app goes to background, not on every lifecycle change
    if (state == AppLifecycleState.paused) {
      _saveIfNeeded(background: true);
    }
  }

  Future<void> _saveIfNeeded({bool background = false}) async {
    final cubit = context.read<NoteCubit>();
    final title = cubit.titleController.text.trim();
    final content = cubit.noteController.text.trim();

    if (title.isEmpty && content.isEmpty) return;
    if (_isSaving) return;
    _isSaving = true;
    try {
      if (_currentNoteId == null) {
        final newId = await cubit.createNote();
        if (newId != null) {
          _currentNoteId = newId;
        }
      } else {
        await cubit.updateNote(_currentNoteId!);
      }
      await cubit.fetchAllNotes();
    } finally {
      _isSaving = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();

    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          await _saveIfNeeded();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.noteId == null ? 'Create Note' : 'Edit Note'),
            actions: [
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () async {
                  await _saveIfNeeded();
                  if (mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  TitleTextFiled(controller: cubit.titleController),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Divider(),
                  ),
                  NoteTextFiled(controller: cubit.noteController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
