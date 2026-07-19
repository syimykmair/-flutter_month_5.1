import 'package:injectable/injectable.dart';
import 'package:news_app/core/util/transformable.dart';
import 'package:news_app/features/everything/domain/repo/everything_repo.dart';
import 'package:paging_view/paging_view.dart';
import '../../../home/domain/entities/news_article_entity.dart';

@injectable
class EverythingNewsPagingAdapter extends DataSource<int, NewsArticleEntity> {
  EverythingNewsPagingAdapter({required this.everythingRepository});

  final EverythingRepository everythingRepository;

  static const int pageSize = 20;
  static const int firstPage = 1;
  String _query = "";

  void search(String query) {
    _query = query;
    refresh();
  }

  // метод который отвечает за пагинацию
  @override
  Future<LoadResult<int, NewsArticleEntity>> load(
    LoadAction<int> action,
  ) async {
    return switch (action) {
      //вызывается при загрузке первой страницы
      Refresh() => _fetchData(firstPage),
      //вызывается при загрузке последующей страницы
      Append(:final key) => _fetchData(key),
      //вызывается при загрузке предыдущей страницы,
      // но мы его не изпользуем потомучто список идет вниз
      Prepend() => None(),
    };
  }

  // метод для выполнения запроса
  Future<LoadResult<int, NewsArticleEntity>> _fetchData(int page) async {
    try {
      //запрос на получение данных каждой страницы
      final data = await everythingRepository.getEverythingPageNews(
        page: page,
        pageSize: pageSize,
        query: _query,
      );
      // сколько статей мы уже загрузили
      final int loadedCount =
          ((page - 1) * pageSize) + (data.articles?.length ?? 0);
      //проверка, продолжать ли пагинацию
      final bool hasMore =
          data.articles != null &&
          data.articles!.isNotEmpty &&
          loadedCount < (data.totalResults ?? 0);

      int? nextPage;

      if (hasMore) {
        nextPage = page + 1;
      }
      return Success(
        page: PageData(
          data: data.articles?.transform() ?? [],
          appendKey: nextPage,
        ),
      );
    } catch (e) {
      return Failure(error: e);
    }
  }
}
