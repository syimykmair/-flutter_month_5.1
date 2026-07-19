import 'package:flutter/material.dart';
import 'package:news_app/core/di/service_locator.dart';
import 'package:news_app/features/everything/ui/paging_adapter/everything_news_paging_adapter.dart';
import 'package:news_app/features/everything/ui/widgets/everything_news_title.dart';
import 'package:paging_view/paging_view.dart';

import '../../home/ui/pages/news_details_page.dart';
import '../../home/ui/widgets/news_search_bar.dart';
class EverythingPage extends StatefulWidget {
  const EverythingPage({super.key});

  @override
  State<EverythingPage> createState() => _EverythingPageState();
}

class _EverythingPageState extends State<EverythingPage> {
  final TextEditingController searchController =
  TextEditingController();

  late final EverythingNewsPagingAdapter pagingAdapter =
  getIt<EverythingNewsPagingAdapter>();

  @override
  void dispose() {
    pagingAdapter.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewsSearchBar(
          controller: searchController,
          onSearch: () {
            pagingAdapter.search(
              searchController.text,
            );
          },
          onClear: () {
            searchController.clear();
            pagingAdapter.search("");
          },
        ),

        const SizedBox(height: 16),

        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              pagingAdapter.refresh();
            },
            child: PagingGrid(
              dataSource: pagingAdapter,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.62,
              ),
              builder: (context, article, index) {
                return EverythingNewsTitle(
                  article: article,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsPage(
                          article: article,
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ),
        ),
      ],
    );
  }
}