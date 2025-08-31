import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/data/data_source/theme_data_source.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/use_cases/add_note.dart';
import 'package:notes_app/domain/use_cases/delete_all_notes.dart';
import 'package:notes_app/domain/use_cases/delete_note_by_id.dart';
import 'package:notes_app/domain/use_cases/get_all_notes.dart';
import 'package:notes_app/presentation/view/create_note_screen.dart';
import 'package:uuid/uuid.dart';
import '../../domain/use_cases/get_note_by_id.dart';
import '../../domain/use_cases/update_note.dart';
import 'note_state.dart';

@injectable
class NoteCubit extends Cubit<NoteState> {
  final AddNote _addNoteUseCase;
  final DeleteNoteById _deleteNoteUseCase;
  final GetAllNotes _fetchAllNotesUseCase;
  final GetNoteById _fetchNoteByIdUseCase;
  final UpdateNote _updateNoteUseCase;
  final DeleteAllNotes _deleteAllNotesUseCase;

  final id = Uuid();
  final titleController = TextEditingController();
  final noteController = TextEditingController();

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

  /// Create a new note if title or content is not empty
  Future<bool> createNote() async {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      return false;
    }

    await _addNoteUseCase.executeAddNote(
      NoteEntity(
        title: title,
        content: content,
        id: id.v4(),
        createdAt: DateTime.now().toString(),
      ),
    );
    emit(AddNoteState());

    return true;
  }

  /// Update existing note (must already have an ID)
  Future<void> modifyNote() async {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      return;
    }

    await _updateNoteUseCase.executeUpdateNote(
      NoteEntity(title: title, content: content),
    );
    emit(EditNoteState());
  }

  /// Delete a note by its ID
  Future<void> removeNote(String id) async {
    await _deleteNoteUseCase.executeDeleteNoteById(id);
    emit(RemoveNoteState());
  }

  /// Fetch a single note by ID
  Future<void> fetchNoteById(String id) async {
    final noteResponse = await _fetchNoteByIdUseCase.executeGetNoteById(id);

    noteResponse.fold(
      (error) => emit(NoteError(message: error.errorMessage)),
      (note) => emit(GetNoteState(note: note!)),
    );
  }

  /// Button action: Save note, refresh list, clear fields, and go back
  Future<void> backToNotesScreenButton(BuildContext context) async {
    final noteCreated = await createNote();

    if (noteCreated) {
      await fetchAllNotes();
    }
    clearControllers();
    Navigator.pop(context);
  }

  /// Delete all notes in the database
  Future<void> deleteAllnotes() async {
    await _deleteAllNotesUseCase.executeDeleteAllNote();
    emit(NoteEmpty());
  }

  /// Helper method to check if user entered something
  bool get hasNoteContent {
    final title = titleController.text.trim();
    final content = noteController.text.trim();
    return title.isNotEmpty || content.isNotEmpty;
  }

  /// Navigate to Add Note screen
  void addNoteButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteScreen()),
    );
  }

  // Clear text controllers
  void clearControllers() {
    titleController.clear();
    noteController.clear();
  }

  /// Navigate to Edit Note screen (future use)
  void editNoteButton() {}

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
