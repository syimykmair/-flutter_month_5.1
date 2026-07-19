import 'package:injectable/injectable.dart';
import 'package:news_app/core/util/transformable.dart';
import 'package:news_app/features/everything/data/data_source/abstract/everything_data_source.dart';
import 'package:news_app/features/everything/data/model/everything_response_model.dart';
import 'package:news_app/features/everything/domain/repo/everything_repo.dart';
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';
import 'package:news_app/features/home/domain/entities/news_article_entity.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

@LazySingleton(as: EverythingRepository)
class EverythingRepoImpl extends EverythingRepository {
  EverythingRepoImpl({required this.everythingDataSource});

  final EverythingDataSource everythingDataSource;

  @override
  Future<EverythingResponseModel> getEverythingPageNews({
    required int page,
    required int pageSize,
    String? query,
  }) async {
    final EverythingResponseModel data = await everythingDataSource
        .getEverythingPageNews(page: page, pageSize: pageSize, query: query);
    return data;
  }
}
