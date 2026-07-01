import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';

class NewsLocalDataSourceImpl extends NewsDataSource {
  @override
  Future<List<NewsArticleModel>> getEverythingNews() {
    // TODO: implement getEverythingNews
    throw UnimplementedError();
  }
  
  @override
  Future<List<NewsArticleModel>> searchNews(String query) {
    // TODO: implement searchNews
    throw UnimplementedError();
  }

}