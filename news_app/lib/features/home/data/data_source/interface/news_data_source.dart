import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract class NewsDataSource {
  Future<List<NewsArticleModel>> getEverythingNews();
}