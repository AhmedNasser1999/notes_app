import 'package:injectable/injectable.dart';
import 'package:notes_app/data/repository/note_repo_impl.dart';

@lazySingleton
class DeleteAllNotes {
  NoteRepoImpl noteRepoImpl;

  DeleteAllNotes(this.noteRepoImpl);

  Future<void> executeDeleteAllNote()async {
   await noteRepoImpl.deleteAllNotes();
  }
}
