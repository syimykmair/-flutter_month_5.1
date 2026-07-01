import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/home/domain/bloc/home_bloc.dart';
import 'package:news_app/features/home/domain/bloc/home_event.dart';
import 'package:news_app/features/home/domain/bloc/home_state.dart';
import 'package:news_app/features/home/ui/news_details_page.dart';
import 'package:news_app/features/home/ui/widgets/news_search_bar.dart';

import 'widgets/news_article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(GetNewsEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is HomeFailure) {
                return Center(
                  child: Text(
                    "Ошибка запроса ${state.message}",
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                );
              }

              if (state is HomeSuccess) {
                return Column(
                  children: [
                    NewsSearchBar(
                      controller: _controller,

                      onSearch: () {
                        final text = _controller.text.trim();

                        if (text.isNotEmpty) {
                          context.read<HomeBloc>().add(SearchNewsEvent(text));
                        }
                      },

                      onClear: () {
                        _controller.clear();
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
              return SizedBox();
            },
          ),
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
