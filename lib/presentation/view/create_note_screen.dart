import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/widgets/category_editor.dart';
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
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  String? _currentNoteId;
  bool _isSaving = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _currentNoteId = widget.noteId;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
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
    final theme = Theme.of(context);

    return BlocBuilder<NoteCubit, NoteState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          await _saveIfNeeded();
          // Run reverse animation before popping
          await _animationController.reverse();
          // Always reload notes when returning to main screen
          await cubit.fetchAllNotes();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.noteId == null ? 'Create Note' : 'Edit Note',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.check, color: theme.colorScheme.primary),
                onPressed: () async {
                  await _saveIfNeeded();
                  await _animationController.reverse();
                  // Always reload notes when returning to main screen
                  await cubit.fetchAllNotes();
                  if (mounted) Navigator.pop(context);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextFiled(controller: cubit.titleController),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Divider(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        thickness: 1.0,
                      ),
                    ),
                    NoteTextFiled(controller: cubit.noteController),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        thickness: 1.0,
                      ),
                    ),
                    CategoryEditor(
                      initialCategories: cubit.currentNoteCategories,
                      onCategoriesChanged: cubit.updateCategories,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: ScaleTransition(
            scale: _fadeAnimation,
            child: FloatingActionButton(
              onPressed: () async {
                await _saveIfNeeded();
                await _animationController.reverse();
                // Always reload notes when returning to main screen
                await cubit.fetchAllNotes();
                if (mounted) Navigator.pop(context);
              },
              tooltip: 'Save Note',
              child: const Icon(Icons.save),
            ),
          ),
        ),
      ),
    );
  }
}
