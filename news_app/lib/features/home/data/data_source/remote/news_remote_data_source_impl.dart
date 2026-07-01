import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract final class _ApiPath{
  static const String apiKey = "71d89107035841eab9cdf8954d250577";
}
@LazySingleton(as: NewsDataSource)
class NewsRemoteDataSourceImpl extends NewsDataSource {
  NewsRemoteDataSourceImpl ({required this.dio});

  final Dio dio;
  @override
  Future<List<NewsArticleModel>> getEverythingNews() async {
  
  final response = await dio.get(
    "v2/top-headlines",
    queryParameters: {
      "country": "us",
      "apiKey": _ApiPath.apiKey,
    },
  );

  return NewsArticleModel.fromJsonList(response.data['articles']);
}
  
@override
  Future<List<NewsArticleModel>> searchNews(String query) async {
    final response = await dio.get(
      "v2/everything",
      queryParameters: {
        "q": query,
        "apiKey": _ApiPath.apiKey,
      },
    );

    return NewsArticleModel.fromJsonList(response.data['articles']);
  }
}