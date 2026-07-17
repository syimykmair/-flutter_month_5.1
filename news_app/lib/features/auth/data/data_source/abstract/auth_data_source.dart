import 'package:news_app/features/home/data/model/news_article_model.dart';

abstract class AuthDataSource {
  Future<bool> auth(String login, String password);
}
