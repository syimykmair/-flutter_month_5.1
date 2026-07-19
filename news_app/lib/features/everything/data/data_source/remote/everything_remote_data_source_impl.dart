import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/everything/data/data_source/abstract/everything_data_source.dart';
import 'package:news_app/features/everything/data/model/everything_response_model.dart';
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract final class _ApiPath {
  static const String apiKey = "71d89107035841eab9cdf8954d250577";
}

@LazySingleton(as: EverythingDataSource)
class EverythingRemoteDataSourceImpl extends EverythingDataSource {
  EverythingRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<EverythingResponseModel> getEverythingPageNews({
    required int page,
    required int pageSize,
    String? query,
  }) async {
    final bool isSearch = query != null && query.isNotEmpty;
    final response = await dio.get(
      isSearch
          ? "v2/everything"
          : "v2/top-headlines",
      queryParameters: {
        "apiKey": _ApiPath.apiKey,
        if (isSearch)
          "q": query,

        if (!isSearch)
          "country": "us",
        "pageSize": pageSize,
        "page": page,


      },
    );

    return EverythingResponseModel.fromJson(response.data);
  }
}
