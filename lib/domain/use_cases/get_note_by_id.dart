import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/error/failure.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';
import 'package:notes_app/domain/entities/note_entity.dart';

@lazySingleton
class GetNoteById {
  NoteRepoImpl noteRepoImpl;

  GetNoteById(this.noteRepoImpl);

  Future<Either<Failure, NoteEntity?>> executeGetNoteById(String id) async {
    return await noteRepoImpl.getNoteById(id);
  }
}
