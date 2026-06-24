import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/domain/bloc/home_bloc.dart';
import 'package:news_app/features/home/domain/bloc/home_event.dart';
import 'package:news_app/features/home/domain/bloc/home_state.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';
import 'package:news_app/features/home/ui/news_details_page.dart';

import 'widgets/news_article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.repository});

  final NewsRepository repository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeBloc(newsRepository: widget.repository)..add(GetNewsEvent()),
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
  return NewsArticlesList(
    articles: state.news,
    onTap: (article) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewsDetailsPage(
            article: article,
          ),
        ),
      );
    },
  );
}
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
