import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/error/failure.dart';
import 'package:notes_app/data/data_source/note_data_sourch_impl.dart';
import 'package:notes_app/data/models/note_model.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/repository/note_repo.dart';

@lazySingleton
class NoteRepoImpl implements NoteRepo {
  NoteDataSourchImpl noteDataSourchImpl;

  NoteRepoImpl(this.noteDataSourchImpl);
  //______________________________________________________________

  @override
  Future<void> deleteNoteById(String id) async {
    await noteDataSourchImpl.deleteNoteById(id);
  }

  //______________________________________________________________
  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final noteList = await noteDataSourchImpl.getAllNotes();
      final entityList = noteList
          .map(
            (note) => NoteEntity(
              id: note.id,
              title: note.title,
              content: note.content,
              createdAt: note.createdAt,
              updatedAt: note.updatedAt,
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
      id: noteEntity.id,
      title: noteEntity.title,
      content: noteEntity.content,
      createdAt: noteEntity.createdAt,
      updatedAt: noteEntity.updatedAt,
    );
    await noteDataSourchImpl.updateNote(noteModel);
  }
  //______________________________________________________________

  @override
  Future<Either<Failure, NoteEntity?>> getNoteById(String id) async {
    try {
      final noteEntity = await noteDataSourchImpl.getNoteById(id);
      return Right(noteEntity);
    } catch (e) {
      return Left(LocalFailure(errorMessage: e.toString()));
    }
  }
  //______________________________________________________________

  @override
  Future<void> addNote(NoteEntity noteEntity) async {
    final noteModel = NoteModel(
      id: noteEntity.id,
      title: noteEntity.title,
      content: noteEntity.content,
      createdAt: noteEntity.createdAt,
      updatedAt: noteEntity.updatedAt,
    );

    await noteDataSourchImpl.addNote(noteModel);
  }
}
