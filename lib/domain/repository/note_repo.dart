import 'package:dartz/dartz.dart';
import 'package:notes_app/core/error/failure.dart';
import 'package:notes_app/domain/entities/note_entity.dart';

abstract class NoteRepo {
  Future<void> addNote(NoteEntity noteEntity);

  Future<Either<Failure, NoteEntity?>> getNoteById(String id);

  Future<void> updateNote(NoteEntity noteEntity);

  Future<Either<Failure, List<NoteEntity>>> getAllNotes();

  Future<void> deleteNoteById(String id);
}
