import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/domain/entities/note_entity.dart';
import 'package:notes_app/domain/use_cases/add_note.dart';
import 'package:notes_app/domain/use_cases/delete_note_by_id.dart';
import 'package:notes_app/domain/use_cases/get_all_notes.dart';
import '../../domain/use_cases/get_note_by_id.dart';
import '../../domain/use_cases/update_note.dart';
import 'note_state.dart';

@injectable
class NoteCubit extends Cubit<NoteState> {
  final AddNote _addNoteUseCase;
  final DeleteNoteById _deleteNoteUseCase;
  final GetAllNotes _fetchAllNotesUseCase;
  final GetNoteById _fetchNoteByIdUseCase;
  final UpdateNote _updateNoteUseCase;

  NoteCubit(
    this._addNoteUseCase,
    this._deleteNoteUseCase,
    this._fetchAllNotesUseCase,
    this._fetchNoteByIdUseCase,
    this._updateNoteUseCase,
  ) : super(NoteInitial());

  Future<void> fetchAllNotes() async {}

  Future<void> createNote(NoteEntity note) async {}

  Future<void> modifyNote(NoteEntity note) async {}

  Future<void> removeNote(String id) async {}

  Future<void> fetchNoteById(String id) async {}
}
