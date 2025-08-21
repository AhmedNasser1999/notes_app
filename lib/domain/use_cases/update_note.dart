import 'package:injectable/injectable.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';
import 'package:notes_app/domain/entities/note_entity.dart';

@lazySingleton
class UpdateNote {
  NoteRepoImpl noteRepoImpl;

  UpdateNote(this.noteRepoImpl);

  Future<void> executeUpdateNote(NoteEntity noteEntity) async {
    await noteRepoImpl.updateNote(noteEntity);
  }
}
