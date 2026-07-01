import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app/features/home/domain/bloc/home_event.dart';
import 'package:news_app/features/home/domain/bloc/home_state.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.newsRepository}) : super(HomeInitial()) {
    on<GetNewsEvent>(_getNewsEvent);
    on<SearchNewsEvent>(_searchNews);
  }

  final NewsRepository newsRepository;

  FutureOr<void> _getNewsEvent(
    GetNewsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final result = await newsRepository.getEverythingNews();
      emit(HomeSuccess(result));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> _searchNews(
    SearchNewsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final result = await newsRepository.searchNews(event.query);
      emit(HomeSuccess(result));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
