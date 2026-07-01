// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/core/di/service_locator.dart' as _i532;
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart'
    as _i791;
import 'package:news_app/features/home/data/data_source/remote/news_remote_data_source_impl.dart'
    as _i598;
import 'package:news_app/features/home/data/repo_impl/news_repo_impl.dart'
    as _i173;
import 'package:news_app/features/home/domain/bloc/home_bloc.dart' as _i950;
import 'package:news_app/features/home/domain/repo/news_repo.dart' as _i710;
import 'package:talker_dio_logger/talker_dio_logger.dart' as _i52;
import 'package:talker_flutter/talker_flutter.dart' as _i207;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.lazySingleton<_i207.Talker>(() => appModule.talker);
    gh.lazySingleton<_i52.TalkerDioLogger>(() => appModule.talkerDioLogger);
    gh.lazySingleton<_i361.Dio>(() => appModule.dio());
    gh.lazySingleton<_i791.NewsDataSource>(
      () => _i598.NewsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i710.NewsRepository>(
      () => _i173.NewsRepoImpl(newsDataSource: gh<_i791.NewsDataSource>()),
    );
    gh.factory<_i950.HomeBloc>(
      () => _i950.HomeBloc(newsRepository: gh<_i710.NewsRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i532.AppModule {}
