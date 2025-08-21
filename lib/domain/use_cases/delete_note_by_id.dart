import 'package:injectable/injectable.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';

@lazySingleton
class DeleteNoteById {
  NoteRepoImpl noteRepoImpl;

  DeleteNoteById(this.noteRepoImpl);

  Future<void> executeDeleteNoteById(String id) async {
    await noteRepoImpl.deleteNoteById(id);
  }
}
