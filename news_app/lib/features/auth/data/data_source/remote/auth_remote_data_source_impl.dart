import 'package:dio/dio.dart';
import 'package:news_app/core/service/secure_storage_service.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../abstract/auth_data_source.dart';

abstract final class _ApiPath {
  static const String auth = "api/auth";
}

class AuthRemoteDataSourceImpl extends AuthDataSource {
  AuthRemoteDataSourceImpl(this._secureStorageService, this._talkerDioLogger);

  final SecureStorageService _secureStorageService;
  final TalkerDioLogger _talkerDioLogger;

  @override
  Future<bool> auth(String login, String password) async {
    final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://syimyk-flutter.free.beeceptor.com/'),
    );
    dio.interceptors.add(_talkerDioLogger);

    final response = await dio.post(
      _ApiPath.auth,
      data: {'login': login, 'password': password},
    );

    final accessToken = await response.data['access_token'];
    final refreshToken = await response.data['refresh_token'];

    await _secureStorageService.write(
      KeySecureStorage.accessTokenKey,
      accessToken,
    );
    await _secureStorageService.write(
      KeySecureStorage.refreshTokenKey,
      refreshToken,
    );

    if (response.statusCode == 200 && response.data != null) {
      return true;
    }
    return false;
  }
}
