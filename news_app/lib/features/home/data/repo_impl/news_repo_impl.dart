import 'package:news_app/features/home/data/data_source/interface/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';
import 'package:news_app/features/home/domain/entities/news_article_entity.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

class NewsRepoImpl extends NewsRepository {

  NewsRepoImpl({required this.newsDataSource});
  
  final NewsDataSource newsDataSource;

  @override
  Future<List<NewsArticleEntity>> getEverythingNews() async{
    final List<NewsArticleModel> data = await newsDataSource.getEverythingNews();
    return data.map((model)=> model.convertToEntity()).toList();
  }

}