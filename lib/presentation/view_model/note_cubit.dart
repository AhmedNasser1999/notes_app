import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/error/failure.dart';
import 'package:notes_app/data/data_source/theme_data_source.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/use_cases/add_note.dart';
import 'package:notes_app/domain/use_cases/delete_all_notes.dart';
import 'package:notes_app/domain/use_cases/delete_note_by_id.dart';
import 'package:notes_app/domain/use_cases/get_all_notes.dart';
import 'package:notes_app/domain/use_cases/get_note_by_id.dart';
import 'package:notes_app/domain/use_cases/update_note.dart';
import 'package:uuid/uuid.dart' show Uuid;
import 'note_state.dart';
import '../view/create_note_screen.dart';

@injectable
class NoteCubit extends Cubit<NoteState> {
  final AddNote _addNoteUseCase;
  final DeleteNoteById _deleteNoteUseCase;
  final GetAllNotes _fetchAllNotesUseCase;
  final GetNoteById _fetchNoteByIdUseCase;
  final UpdateNote _updateNoteUseCase;
  final DeleteAllNotes _deleteAllNotesUseCase;

  final id = Uuid();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  bool isDark = false;

  NoteCubit(
    this._addNoteUseCase,
    this._deleteNoteUseCase,
    this._fetchAllNotesUseCase,
    this._fetchNoteByIdUseCase,
    this._updateNoteUseCase,
    this._deleteAllNotesUseCase, {
    required this.isDark,
  }) : super(NoteInitial());

  /// Fetch all notes from database
  Future<void> fetchAllNotes() async {
    final notesResponse = await _fetchAllNotesUseCase.executeGetAllNotes();

    notesResponse.fold(
      (error) => emit(NoteError(message: error.errorMessage)),
      (notesList) {
        if (notesList.isEmpty) {
          emit(NoteEmpty());
        } else {
          emit(GetAllNotesState(notes: notesList));
        }
      },
    );
  }

  /// Create a new note and return its ID if created
  Future<String?> createNote() async {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) return null;

    final generatedId = id.v4();
    final note = NoteEntity(
      id: generatedId,
      title: title,
      content: content,
      createdAt: DateTime.now().toString(),
    );

    await _addNoteUseCase.executeAddNote(note);
    emit(AddNoteState());
    return generatedId;
  }

  /// Update an existing note
  Future<void> updateNote(String noteId) async {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) return;

    final note = NoteEntity(
      id: noteId,
      title: title,
      content: content,
      createdAt: DateTime.now().toString(),
    );

    await _updateNoteUseCase.executeUpdateNote(note);
    emit(UpdateNoteState());
  }

  /// Load a note and navigate to edit screen
  Future<void> modifyNote(String id, BuildContext context) async {
    final result = await fetchNoteById(id);

    result.fold((error) => emit(NoteError(message: error.errorMessage)), (
      noteEntity,
    ) {
      if (noteEntity == null) return;

      titleController.text = noteEntity.title;
      noteController.text = noteEntity.content;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateNoteScreen(noteId: noteEntity.id),
        ),
      );
    });
  }

  /// Delete a note by its ID
  Future<void> removeNote(String id) async {
    await _deleteNoteUseCase.executeDeleteNoteById(id);
    emit(RemoveNoteState());
  }

  Future<Either<Failure, NoteEntity?>> fetchNoteById(String id) async {
    return await _fetchNoteByIdUseCase.executeGetNoteById(id);
  }

  /// Delete all notes in the database
  Future<void> deleteAllnotes() async {
    await _deleteAllNotesUseCase.executeDeleteAllNote();
    emit(NoteEmpty());
  }

  /// Navigate to Add Note screen
  void addNoteButton(BuildContext context) {
    clearControllers();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNoteScreen()),
    );
  }

  // Clear text controllers
  void clearControllers() {
    titleController.clear();
    noteController.clear();
  }

  ///Change Theme
  void changeTheme() async {
    isDark = !isDark;
    ThemeDataSource.saveTheme(isDark);
    fetchAllNotes();
    emit(ChangeTheme(isDark: isDark));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    noteController.dispose();
    return super.close();
  }
}
