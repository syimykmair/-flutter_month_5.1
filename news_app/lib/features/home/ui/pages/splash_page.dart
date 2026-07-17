import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/service/secure_storage_service.dart';

import '../../../../core/service/preferences_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    checkAuth();
  }

  Future<void> checkAuth() async {
    final preferences = await getIt.getAsync<PreferencesService>();

    if (!preferences.onboardingSeen) {
      if (!mounted) return;

      context.router.replacePath('/onboarding');
      return;
    }

    final secureStorage = getIt<SecureStorageService>();

    final token = await secureStorage.read(KeySecureStorage.accessTokenKey);

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      context.router.replacePath('/home');
    } else {
      context.router.replacePath('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
