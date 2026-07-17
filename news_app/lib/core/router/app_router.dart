import 'package:auto_route/auto_route.dart';
import 'package:news_app/features/auth/ui/pages/auth_page.dart';
import 'package:news_app/features/home/ui/pages/home_page.dart';
import 'package:news_app/features/home/ui/pages/splash_page.dart';

import '../../features/home/ui/pages/onboarding_page.dart';

class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: 'SplashRoute',
      path: '/',
      builder: (_, __) => const SplashPage(),
    ),

    NamedRouteDef(
      name: 'OnboardingRoute',
      path: '/onboarding',
      builder: (_, __) => const OnboardingPage(),
    ),

    NamedRouteDef(
      name: 'AuthRoute',
      path: '/auth',
      builder: (_, __) => const AuthPage(),
    ),

    NamedRouteDef(
      name: 'HomeRoute',
      path: '/home',
      builder: (_, __) => const HomePage(),
    ),
  ];
}
