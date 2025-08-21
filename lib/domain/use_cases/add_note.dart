import 'package:injectable/injectable.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';
import 'package:notes_app/domain/entities/note_entity.dart';

@lazySingleton
class AddNote {
  NoteRepoImpl noteRepoImpl;

  AddNote(this.noteRepoImpl);

  Future<void> executeAddNote(NoteEntity noteEntity) async {
    await noteRepoImpl.addNote(noteEntity);
  }
}
