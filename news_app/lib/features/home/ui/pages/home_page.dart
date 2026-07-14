import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/domain/bloc/home_bloc.dart';
import 'package:news_app/features/home/domain/bloc/home_event.dart';
import 'package:news_app/features/home/domain/bloc/home_state.dart';
import 'package:news_app/features/home/ui/pages/news_details_page.dart';
import 'package:news_app/features/home/ui/widgets/news_search_bar.dart';

import '../widgets/news_article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(GetNewsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              _ExplorePage(controller: _controller),
              const SizedBox.shrink(),
              const SizedBox.shrink(),
            ],
          ),
        ),
        bottomNavigationBar: _NewsBottomNavigation(
          currentIndex: _selectedIndex,
          onChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeFailure) {
          return Center(
            child: Text(
              'Request error: ${state.message}',
              style: const TextStyle(fontSize: 22, color: Colors.red),
            ),
          );
        }

        if (state is HomeSuccess) {
          return Column(
            children: [
              NewsSearchBar(
                controller: controller,
                onSearch: () {
                  final text = controller.text.trim();

                  if (text.isNotEmpty) {
                    context.read<HomeBloc>().add(SearchNewsEvent(text));
                  }
                },
                onClear: () {
                  controller.clear();
                  context.read<HomeBloc>().add(GetNewsEvent());
                },
              ),
              Expanded(
                child: NewsArticlesList(
                  articles: state.news,
                  onTap: (article) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailsPage(article: article),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _NewsBottomNavigation extends StatelessWidget {
  const _NewsBottomNavigation({
    required this.currentIndex,
    required this.onChanged,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 104,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F1F0),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavigationItem(
              icon: 'assets/icons/search.png',
              label: 'EXPLORE',
              isSelected: currentIndex == 0,
              onTap: () => onChanged(0),
            ),
            _NavigationItem(
              icon: 'assets/icons/fav.png',
              label: 'FAVOURITE',
              isSelected: currentIndex == 1,
              onTap: () => onChanged(1),
            ),
            _NavigationItem(
              icon: 'assets/icons/menu.png',
              label: 'MENU',
              isSelected: currentIndex == 2,
              onTap: () => onChanged(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isSelected ? 2 : 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(34),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: 34,
                height: 34,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                child: isSelected
                    ? Padding(
                        key: const ValueKey('label'),
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF1F1F1F),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
