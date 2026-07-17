import 'package:news_app/core/util/transformable.dart';
import 'package:news_app/features/auth/data/data_source/abstract/auth_data_source.dart';
import 'package:news_app/features/auth/domain/repo/auth_repo.dart';
import 'package:news_app/features/home/data/data_source/abstract/news_data_source.dart';
import 'package:news_app/features/home/data/model/news_article_model.dart';
import 'package:news_app/features/home/domain/entities/news_article_entity.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

class AuthRepoImpl extends AuthRepository {
  AuthRepoImpl({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<bool> auth(String login, String password) async {
    return await authDataSource.auth(login, password);
  }
}
