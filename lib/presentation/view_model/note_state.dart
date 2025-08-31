import 'package:notes_app/domain/entities/note_entity.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteEmpty extends NoteState {}

class AddNoteState extends NoteState {}

class RemoveNoteState extends NoteState {}

class RemoveAllNotesState extends NoteState {}

class EditNoteState extends NoteState {}

class GetAllNotesState extends NoteState {
  final List<NoteEntity> notes;

  GetAllNotesState({required this.notes});
}

class GetNoteState extends NoteState {
  final NoteEntity note;
  GetNoteState({required this.note});
}

class NoteError extends NoteState {
  final String message;

  NoteError({required this.message});
}

class ChangeTheme extends NoteState {
  final bool isDark;
  ChangeTheme({required this.isDark});
}
