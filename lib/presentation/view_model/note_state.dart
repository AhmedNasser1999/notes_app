import 'package:notes_app/domain/entities/note_entity.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteEmpty extends NoteState {}

class AddNoteState extends NoteState {}

class RemoveNoteState extends NoteState {}

class RemoveAllNotesState extends NoteState {}

class UpdateNoteState extends NoteState {}

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

class ClearControllers extends NoteState {}

// Missing states that are used in NotesBody
class NoteLoading extends NoteState {}

class NoteSuccess extends NoteState {
  final List<NoteEntity> notes;
  
  NoteSuccess({required this.notes});
}

class NoteFailure extends NoteState {
  final String message;
  
  NoteFailure({required this.message});
}

class SortNoteState extends NoteState {
  final List<NoteEntity> notes;
  
  SortNoteState({required this.notes});
}
