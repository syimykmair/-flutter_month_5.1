import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/core/di/service_locator.config.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;

@InjectableInit()
void setupServiceLocator() => getIt.init();

@module
abstract class AppModule {
  @lazySingleton
  Talker get talker => TalkerFlutter.init();

  @lazySingleton
  TalkerDioLogger get talkerDioLogger => TalkerDioLogger(
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

  @lazySingleton
  Dio dio() {
    final Dio dio = Dio(BaseOptions(baseUrl: "https://newsapi.org/"));
    dio.interceptors.add(talkerDioLogger);
    return dio;
  }
}