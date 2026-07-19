import 'package:news_app/features/home/data/model/news_article_model.dart';

class EverythingResponseModel {
  final int? totalResults;
  final List<NewsArticleModel>? articles;

  EverythingResponseModel({this.totalResults, this.articles});

  factory EverythingResponseModel.fromJson(Map<String, dynamic> json) {
    final articlesJson = json['articles'];
    return EverythingResponseModel(
      totalResults: json['totalResults'] as int?,
      articles: NewsArticleModel.fromJsonList(articlesJson),
    );
  }
}
