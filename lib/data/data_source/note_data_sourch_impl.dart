import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/hive/data_source/note_data_source.dart';

@lazySingleton
class NoteDataSourchImpl implements NoteDataSource {
  final Box<NoteModel> box;

  NoteDataSourchImpl(this.box);

  @override
  Future<void> addNote(NoteModel note) async {
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteNoteById(String id) async {
    await box.delete(id);
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final notes = box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return notes;
  }

  @override
  Future<NoteModel?> getNoteById(String id) async {
    return box.get(id);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await box.put(note.id, note);
  }

  @override
  Future<void> deleteAllNotes() async {
    await box.clear();
  }
}
