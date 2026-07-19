import 'package:news_app/features/everything/data/model/everything_response_model.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract class EverythingDataSource {
  Future<EverythingResponseModel> getEverythingPageNews({
    required int page,
    required int pageSize,
    String? query,
  });
}
