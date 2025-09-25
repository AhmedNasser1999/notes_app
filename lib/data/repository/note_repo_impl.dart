import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/error/failure.dart';
import 'package:notes_app/data/data_source/note_data_source_impl.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/repository/note_repo.dart';

@lazySingleton
class NoteRepoImpl implements NoteRepo {
  NoteDataSourceImpl noteDataSourceImpl;

  NoteRepoImpl(this.noteDataSourceImpl);
  //______________________________________________________________

  @override
  Future<void> deleteNoteById(String id) async {
    await noteDataSourceImpl.deleteNoteById(id);
  }

  //______________________________________________________________
  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final noteList = await noteDataSourceImpl.getAllNotes();
      final entityList = noteList
          .map(
            (note) => NoteEntity(
              title: note.title,
              content: note.content,
              id: note.id,
              createdAt: note.createdAt,
              // updatedAt: note.updatedAt,
            ),
          )
          .toList();

      return Right(entityList);
    } catch (e) {
      return Left(LocalFailure(errorMessage: e.toString()));
    }
  }
  //______________________________________________________________

  @override
  Future<void> updateNote(NoteEntity noteEntity) async {
    final noteModel = NoteModel(
      title: noteEntity.title,
      content: noteEntity.content,
      id: noteEntity.id,
      createdAt: noteEntity.createdAt,
      // updatedAt: noteEntity.updatedAt,
    );
    await noteDataSourceImpl.updateNote(noteModel);
  }
  //______________________________________________________________

  @override
  Future<Either<Failure, NoteEntity?>> getNoteById(String id) async {
    try {
      final noteEntity = await noteDataSourceImpl.getNoteById(id);
      return Right(noteEntity);
    } catch (e) {
      return Left(LocalFailure(errorMessage: e.toString()));
    }
  }
  //______________________________________________________________

  @override
  Future<void> addNote(NoteEntity noteEntity) async {
    final noteModel = NoteModel(
      title: noteEntity.title,
      content: noteEntity.content,
      id: noteEntity.id,
      createdAt: noteEntity.createdAt,
      // updatedAt: noteEntity.updatedAt,
    );

    await noteDataSourceImpl.addNote(noteModel);
  }

  @override
  Future<void> deleteAllNotes() async {
    await noteDataSourceImpl.deleteAllNotes();
  }
}
