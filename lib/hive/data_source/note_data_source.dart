import 'package:notes_app/data/models/note_model.dart';

abstract class NoteDataSource {
  Future<void> addNote(NoteModel note);

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNoteById(String id);

  Future<NoteModel?> getNoteById(String id);

  Future<List<NoteModel>> getAllNotes();
}
