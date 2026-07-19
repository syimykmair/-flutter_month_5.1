import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/di/service_locator.config.dart';
import 'package:news_app/features/auth/data/data_source/abstract/auth_data_source.dart';
import 'package:news_app/features/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:news_app/features/auth/data/repi_impl/auth_repo_impl.dart';
import 'package:news_app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/domain/repo/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

@InjectableInit()
void setupServiceLocator() {
  getIt.init();
  getIt
    ..registerLazySingleton<AuthDataSource>(
      () => AuthRemoteDataSourceImpl(getIt(), getIt()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepoImpl(authDataSource: getIt()),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: getIt(), secureStorageService: getIt()),
    );
}
@module
abstract class AppModule {

  @lazySingleton
  Future<SharedPreferences> get sharedPreferences async =>
      await SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get flutterSecureStorage =>
      const FlutterSecureStorage();

  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  @lazySingleton
  TalkerDioLogger talkerDioLogger(Talker talker) {
    return TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: false,
        printResponseData: true,
        printResponseMessage: true,
        printResponseHeaders: true,
        printResponseTime: true,
        hiddenHeaders: {'X-Api-Key'},
      ),
    );
  }

  @lazySingleton
  Dio dio(TalkerDioLogger logger) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
      ),
    );

    dio.interceptors.add(logger);

    return dio;
  }
}
