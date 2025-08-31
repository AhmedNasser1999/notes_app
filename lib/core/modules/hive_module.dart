import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/data/models/note_model.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<NoteModel>> get noteBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    return Hive.openBox<NoteModel>('notes');
  }
}
