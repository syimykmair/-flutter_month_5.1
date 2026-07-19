// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:news_app/core/di/service_locator.dart' as _i532;
import 'package:news_app/core/service/preferences_service.dart' as _i615;
import 'package:news_app/core/service/secure_storage_service.dart' as _i1056;
import 'package:news_app/features/everything/data/data_source/abstract/everything_data_source.dart'
    as _i806;
import 'package:news_app/features/everything/data/data_source/remote/everything_remote_data_source_impl.dart'
    as _i317;
import 'package:news_app/features/everything/data/repo_impl/everything_repo_impl.dart'
    as _i83;
import 'package:news_app/features/everything/domain/repo/everything_repo.dart'
    as _i426;
import 'package:news_app/features/everything/ui/paging_adapter/everything_news_paging_adapter.dart'
    as _i885;
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart'
    as _i791;
import 'package:news_app/features/home/data/data_source/remote/news_remote_data_source_impl.dart'
    as _i598;
import 'package:news_app/features/home/data/repo_impl/news_repo_impl.dart'
    as _i173;
import 'package:news_app/features/home/domain/bloc/home_bloc.dart' as _i950;
import 'package:news_app/features/home/domain/repo/news_repo.dart' as _i710;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
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
    gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => appModule.flutterSecureStorage,
    );
    gh.lazySingleton<_i207.Talker>(() => appModule.talker);
    gh.lazySingleton<_i1056.SecureStorageService>(
      () => _i1056.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i52.TalkerDioLogger>(
      () => appModule.talkerDioLogger(gh<_i207.Talker>()),
    );
    gh.lazySingletonAsync<_i615.PreferencesService>(
      () async =>
          _i615.PreferencesService(await getAsync<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => appModule.dio(gh<_i52.TalkerDioLogger>()),
    );
    gh.lazySingleton<_i791.NewsDataSource>(
      () => _i598.NewsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i806.EverythingDataSource>(
      () => _i317.EverythingRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i710.NewsRepository>(
      () => _i173.NewsRepoImpl(newsDataSource: gh<_i791.NewsDataSource>()),
    );
    gh.lazySingleton<_i426.EverythingRepository>(
      () => _i83.EverythingRepoImpl(
        everythingDataSource: gh<_i806.EverythingDataSource>(),
      ),
    );
    gh.factory<_i885.EverythingNewsPagingAdapter>(
      () => _i885.EverythingNewsPagingAdapter(
        everythingRepository: gh<_i426.EverythingRepository>(),
      ),
    );
    gh.factory<_i950.HomeBloc>(
      () => _i950.HomeBloc(newsRepository: gh<_i710.NewsRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i532.AppModule {}
