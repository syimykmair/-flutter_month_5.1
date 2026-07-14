import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/ui/pages/home_page.dart';

void main() async{
  setupServiceLocator();
  await initializeDateFormatting('ru');
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
