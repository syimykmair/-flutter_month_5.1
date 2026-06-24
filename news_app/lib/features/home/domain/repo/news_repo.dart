import 'package:news_app/features/home/domain/entities/news_article_entity.dart';

abstract class NewsRepository {
  Future <List<NewsArticleEntity>> getEverythingNews();
}