import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/service/preferences_service.dart';
import 'package:news_app/core/di/service_locator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    final seen = getIt<PreferencesService>().onboardingSeen;

    if (seen) {
      if (!mounted) return;

      context.router.replacePath('/');
    }
  }

  final PageController _controller = PageController();

  int currentPage = 0;

  final pages = [
    'Добро пожаловать в News App',

    'Читайте последние новости',

    'Будьте всегда в курсе событий',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,

              itemCount: pages.length,

              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },

              itemBuilder: (_, index) {
                return Center(
                  child: Text(
                    pages[index],

                    style: const TextStyle(fontSize: 28),

                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              if (currentPage == pages.length - 1) {
                await getIt<PreferencesService>().setOnboardingSeen();

                if (!mounted) return;

                context.router.replacePath('/');
              } else {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),

                  curve: Curves.ease,
                );
              }
            },

            child: Text(currentPage == pages.length - 1 ? 'Начать' : 'Далее'),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
