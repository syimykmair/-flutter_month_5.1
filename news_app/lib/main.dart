import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  await getIt.allReady();

  await initializeDateFormatting('ru');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
