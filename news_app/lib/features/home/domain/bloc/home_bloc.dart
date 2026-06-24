import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/domain/bloc/home_event.dart';
import 'package:news_app/features/home/domain/bloc/home_state.dart';
import 'package:news_app/features/home/domain/repo/news_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.newsRepository}) : super(HomeInitial()) {
    on<GetNewsEvent>(_getNewsEvent);
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
}
