import 'package:dio/dio.dart';
import 'package:news_app/features/home/data/data_source/interface/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract final class _ApiPath{
  static const String news =
  "v2/everything?q=sport&from=2026-05-24&sortBy=publishedAt";
  static const String apiKey = "71d89107035841eab9cdf8954d250577";
}

class NewsRemoteDataSourceImpl extends NewsDataSource {
  NewsRemoteDataSourceImpl ({required this.dio});

  final Dio dio;
  @override
  Future<List<NewsArticleModel>> getEverythingNews() async {
    final response = await dio.get(_ApiPath.news, queryParameters: {'apiKey': _ApiPath.apiKey});
    return NewsArticleModel.fromJsonList(response.data['articles']);
  }

}