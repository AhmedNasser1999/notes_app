// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_source/note_data_sourch_impl.dart' as _i666;
import '../../data/models/note_model.dart' as _i1073;
import '../../data/repository/note_repo_impl.dart' as _i439;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i666.NoteDataSourchImpl>(
        () => _i666.NoteDataSourchImpl(gh<_i979.Box<_i1073.NoteModel>>()));
    gh.lazySingleton<_i439.NoteRepoImpl>(
        () => _i439.NoteRepoImpl(gh<_i666.NoteDataSourchImpl>()));
    return this;
  }
}
