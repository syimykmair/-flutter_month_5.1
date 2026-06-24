import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/data/data_source/interface/news_data_source.dart';
import 'package:news_app/features/home/data/data_source/remote/news_remote_data_source_impl.dart';
import 'package:news_app/features/home/data/repo_impl/news_repo_impl.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';
import 'package:news_app/features/home/ui/home_page.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/",
    ),
  );

  dio.interceptors.add(
    TalkerDioLogger(
      talker: TalkerFlutter.init(),
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: false,
        printResponseData: true,
        printResponseMessage: true,
        printResponseHeaders: true,
        printResponseTime: true,
        hiddenHeaders: {'X-Api-Key'},
      ),
    ),
  );

  final NewsDataSource newsRemoteDataSource = NewsRemoteDataSourceImpl(
    dio: dio,
  );

  final NewsRepository newsRepositoryImpl = NewsRepoImpl(
    newsDataSource: newsRemoteDataSource,
  );

  runApp(MyApp(newsRepository: newsRepositoryImpl));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.newsRepository});

  final NewsRepository newsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage(repository: newsRepository));
  }
}
