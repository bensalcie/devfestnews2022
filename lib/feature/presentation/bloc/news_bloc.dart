import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

String BASE_URL = "https://newsapi.org/v2";

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsState()) {
    on<GetNews>(_onGetNews);
  }

  void _onGetNews(GetNews event, Emitter<NewsState> emit) async {
    // Notify UI data is loading.
    emit(state.copyWith(status: NewsStatus.loading));

    try {
      // Get articles from the API.
      List articles = await _getNews();

      // Notify UI loading is completed.
      emit(state.copyWith(articles: articles, status: NewsStatus.loaded));
    } catch (e) {
      // An error occurred.
      // Notify UI something went wrong.
      emit(state.copyWith(status: NewsStatus.error));
    }
  }

  Future<List> _getNews() async {
    try {
      var response = await Dio().get(
          '$BASE_URL/top-headlines?country=us&category=technology&apiKey=8032b416514643b9a80f4779961cdc71');

      return response.data['articles'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onChange(Change<NewsState> change) {
    super.onChange(change);
    print('$change');
  }
}
