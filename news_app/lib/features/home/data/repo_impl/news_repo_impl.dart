import 'package:injectable/injectable.dart';
import 'package:news_app/core/util/transformable.dart';
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';
import 'package:news_app/features/home/domain/entities/news_article_entity.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

@LazySingleton(as: NewsRepository)
class NewsRepoImpl extends NewsRepository {
  NewsRepoImpl({required this.newsDataSource});

  final NewsDataSource newsDataSource;

  @override
  Future<List<NewsArticleEntity>> getEverythingNews() async {
    final List<NewsArticleModel> data = await newsDataSource
        .getEverythingNews();
    return data.transform();

  }
     @override
  Future<List<NewsArticleEntity>> searchNews(String query) async {
    final List<NewsArticleModel> data =
        await newsDataSource.searchNews(query);

    return data.transform();
  }
}
