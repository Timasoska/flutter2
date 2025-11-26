// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter2/data/app_database.dart' as _i451;
import 'package:flutter2/data/video_cards_repository.dart' as _i244;
import 'package:flutter2/pages/home/bloc/home_bloc.dart' as _i692;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.lazySingleton<_i451.AppDatabase>(() => _i451.AppDatabase());
    gh.lazySingleton<_i244.VideoCardsRepository>(
        () => _i244.VideoCardsRepository(gh<_i451.AppDatabase>()));
    gh.factory<_i692.HomeBloc>(
        () => _i692.HomeBloc(gh<_i244.VideoCardsRepository>()));
    return this;
  }
}
