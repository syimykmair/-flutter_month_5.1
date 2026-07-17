import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/auth/domain/cubit/auth_state.dart';
import 'package:news_app/features/auth/domain/repo/auth_repo.dart';

import '../../../../core/service/secure_storage_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository, required this.secureStorageService})
    : super(const AuthInitial());

  final AuthRepository authRepository;
  final SecureStorageService secureStorageService;

  Future<void> auth(String login, String password) async {
    emit(const AuthLoading());

    try {
      final isAuthorized = await authRepository.auth(login, password);

      emit(
        isAuthorized
            ? const AuthSuccess()
            : const AuthFailure('Ошибка авторизации'),
      );
    } catch (error) {
      emit(AuthFailure(error.toString()));
    }
  }

  Future<void> authCheck() async {
    emit(const AuthLoading());

    final token = await secureStorageService.read(
      KeySecureStorage.accessTokenKey,
    );

    if (token != null && token.isNotEmpty) {
      emit(const AuthSuccess());
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    await secureStorageService.delete(KeySecureStorage.accessTokenKey);

    await secureStorageService.delete(KeySecureStorage.refreshTokenKey);

    emit(const AuthUnauthenticated());
  }
}
