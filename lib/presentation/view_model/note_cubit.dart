import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/config/sort_options.dart';
import 'package:notes_app/data/data_source/theme_data_source.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/use_cases/add_note.dart';
import 'package:notes_app/domain/use_cases/delete_all_notes.dart';
import 'package:notes_app/domain/use_cases/delete_note_by_id.dart';
import 'package:notes_app/domain/use_cases/get_all_notes.dart';
import 'package:notes_app/domain/use_cases/get_note_by_id.dart';
import 'package:notes_app/domain/use_cases/update_note.dart';
import 'package:notes_app/presentation/view/create_note_screen.dart';
import 'package:notes_app/presentation/view_model/note_state.dart';
import 'package:uuid/uuid.dart';

@injectable
class NoteCubit extends Cubit<NoteState> {
  final AddNote _addNoteUseCase;
  final DeleteNoteById _deleteNoteByIdUseCase;
  final GetAllNotes _getAllNotesUseCase;
  final GetNoteById _getNoteByIdUseCase;
  final UpdateNote _updateNoteUseCase;
  final DeleteAllNotes _deleteAllNotesUseCase;

  bool isDark;
  SortOption currentSortOption = SortOption.dateNewest;
  List<String> currentNoteCategories = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  NoteCubit(
    this._addNoteUseCase,
    this._deleteNoteByIdUseCase,
    this._getAllNotesUseCase,
    this._getNoteByIdUseCase,
    this._updateNoteUseCase,
    this._deleteAllNotesUseCase, {
    required this.isDark,
  }) : super(NoteInitial());

  Future<void> fetchAllNotes() async {
    emit(NoteLoading());
    final result = await _getAllNotesUseCase.executeGetAllNotes();
    result.fold((failure) => emit(NoteFailure(message: failure.message)), (
      notes,
    ) {
      if (notes.isEmpty) {
        emit(NoteEmpty());
      } else {
        // Apply current sort option to notes
        final sortedNotes = _sortNotes(notes, currentSortOption);
        emit(NoteSuccess(notes: sortedNotes));
      }
    });
  }

  Future<void> getNoteById(String id) async {
    emit(NoteLoading());
    final result = await _getNoteByIdUseCase.executeGetNoteById(id);
    result.fold((failure) => emit(NoteFailure(message: failure.message)), (
      note,
    ) {
      if (note != null) {
        titleController.text = note.title;
        noteController.text = note.content;
        currentNoteCategories = List.from(note.categories);
        emit(GetNoteState(note: note));
      }
    });
  }

  Future<void> deleteNoteById(String id) async {
    emit(NoteLoading());
    try {
      await _deleteNoteByIdUseCase.executeDeleteNoteById(id);
      emit(RemoveNoteState());
      await fetchAllNotes();
    } catch (e) {
      emit(NoteFailure(message: e.toString()));
    }
  }

  Future<void> updateNote(String id) async {
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      emit(NoteFailure(message: 'Title and content cannot both be empty'));
      return;
    }

    emit(NoteLoading());

    try {
      final note = NoteEntity(
        id: id,
        title: title,
        content: content,
        createdAt: DateTime.now().toString(),
        categories: currentNoteCategories,
      );

      await _updateNoteUseCase.executeUpdateNote(note);
      emit(UpdateNoteState());
      await fetchAllNotes();
    } catch (e) {
      emit(NoteFailure(message: e.toString()));
    }
  }

  Future<String?> createNote() async {
    emit(NoteLoading());
    final title = titleController.text.trim();
    final content = noteController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      emit(NoteFailure(message: 'Title and content cannot both be empty'));
      return null;
    }

    final id = const Uuid().v4();
    final note = NoteEntity(
      id: id,
      title: title,
      content: content,
      createdAt: DateTime.now().toString(),
      categories: currentNoteCategories,
    );

    try {
      await _addNoteUseCase.executeAddNote(note);
      emit(AddNoteState());
      await fetchAllNotes();
      return id;
    } catch (e) {
      emit(NoteFailure(message: e.toString()));
      return null;
    }
  }

  Future<void> deleteAllNotes() async {
    emit(NoteLoading());
    try {
      await _deleteAllNotesUseCase.executeDeleteAllNotes();
      emit(RemoveAllNotesState());
      emit(NoteEmpty());
    } catch (e) {
      emit(NoteFailure(message: e.toString()));
    }
  }

  void addNoteButton(BuildContext context) {
    clearControllers();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNoteScreen()),
    );
  }

  void modifyNote(String id, BuildContext context) {
    clearControllers();
    getNoteById(id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteScreen(noteId: id)),
    );
  }

  void clearControllers() {
    titleController.clear();
    noteController.clear();
    currentNoteCategories = [];
    emit(ClearControllers());
  }

  void updateCategories(List<String> categories) {
    currentNoteCategories = categories;
  }

  Future<void> changeTheme() async {
    isDark = !isDark;
    ThemeDataSource.saveTheme(isDark);
    emit(ChangeTheme(isDark: isDark));
    // Reload notes after theme change to prevent them from disappearing
    await fetchAllNotes();
  }

  // New method for sorting notes
  void sortNotes(SortOption sortOption) {
    currentSortOption = sortOption;

    if (state is NoteSuccess) {
      final currentNotes = (state as NoteSuccess).notes;
      final sortedNotes = _sortNotes(currentNotes, sortOption);
      emit(SortNoteState(notes: sortedNotes));
    }
  }

  // Helper method to sort notes based on the selected option
  List<NoteEntity> _sortNotes(List<NoteEntity> notes, SortOption sortOption) {
    final List<NoteEntity> sortedNotes = List.from(notes);

    switch (sortOption) {
      case SortOption.dateNewest:
        sortedNotes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortOption.dateOldest:
        sortedNotes.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortOption.titleAZ:
        sortedNotes.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
      case SortOption.titleZA:
        sortedNotes.sort(
          (a, b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()),
        );
        break;
    }

    return sortedNotes;
  }

  @override
  Future<void> close() {
    titleController.dispose();
    noteController.dispose();
    return super.close();
  }
}
