import 'package:news_app/features/home/domain/entities/news_article_entity.dart';

abstract class AuthRepository {
  Future<bool> auth(String login, String password);
}
