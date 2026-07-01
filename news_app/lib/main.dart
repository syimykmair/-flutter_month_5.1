import 'package:flutter/material.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/ui/home_page.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
