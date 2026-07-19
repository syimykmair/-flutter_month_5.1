import 'package:news_app/features/everything/data/model/everything_response_model.dart';

abstract class EverythingRepository {
  Future<EverythingResponseModel> getEverythingPageNews({
    required int page,
    required int pageSize,
    String? query,


  });
}
