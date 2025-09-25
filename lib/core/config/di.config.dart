// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_source/note_data_source_impl.dart' as _i383;
import '../../data/models/note_model.dart' as _i1073;
import '../../data/repository/note_repo_impl.dart' as _i439;
import '../../domain/use_cases/add_note.dart' as _i367;
import '../../domain/use_cases/delete_all_notes.dart' as _i955;
import '../../domain/use_cases/delete_note_by_id.dart' as _i132;
import '../../domain/use_cases/get_all_notes.dart' as _i332;
import '../../domain/use_cases/get_note_by_id.dart' as _i834;
import '../../domain/use_cases/update_note.dart' as _i778;
import '../../presentation/view_model/note_cubit.dart' as _i974;
import '../modules/hive_module.dart' as _i732;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final hiveModule = _$HiveModule();
    await gh.factoryAsync<_i986.Box<_i1073.NoteModel>>(
      () => hiveModule.noteBox,
      preResolve: true,
    );
    gh.lazySingleton<_i383.NoteDataSourceImpl>(
        () => _i383.NoteDataSourceImpl(gh<_i979.Box<_i1073.NoteModel>>()));
    gh.lazySingleton<_i439.NoteRepoImpl>(
        () => _i439.NoteRepoImpl(gh<_i383.NoteDataSourceImpl>()));
    gh.lazySingleton<_i132.DeleteNoteById>(
        () => _i132.DeleteNoteById(gh<_i439.NoteRepoImpl>()));
    gh.lazySingleton<_i778.UpdateNote>(
        () => _i778.UpdateNote(gh<_i439.NoteRepoImpl>()));
    gh.lazySingleton<_i834.GetNoteById>(
        () => _i834.GetNoteById(gh<_i439.NoteRepoImpl>()));
    gh.lazySingleton<_i332.GetAllNotes>(
        () => _i332.GetAllNotes(gh<_i439.NoteRepoImpl>()));
    gh.lazySingleton<_i367.AddNote>(
        () => _i367.AddNote(gh<_i439.NoteRepoImpl>()));
    gh.lazySingleton<_i955.DeleteAllNotes>(
        () => _i955.DeleteAllNotes(gh<_i439.NoteRepoImpl>()));
    gh.factory<_i974.NoteCubit>(() => _i974.NoteCubit(
          gh<_i367.AddNote>(),
          gh<_i132.DeleteNoteById>(),
          gh<_i332.GetAllNotes>(),
          gh<_i834.GetNoteById>(),
          gh<_i778.UpdateNote>(),
          gh<_i955.DeleteAllNotes>(),
          isDark: gh<bool>(),
        ));
    return this;
  }
}

class _$HiveModule extends _i732.HiveModule {}
