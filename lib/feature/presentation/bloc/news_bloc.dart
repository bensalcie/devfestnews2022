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
    //emit();

    List articles = await _getNews();

    if (articles.isNotEmpty) {
      emit(NewsLoaded(articles));
    } else {
      emit(const NewsFail('Something went wrong.'));
    }
  }

  Future<List> _getNews() async {
    var response = await Dio().get(
        '$BASE_URL/top-headlines?country=us&category=technology&apiKey=8032b416514643b9a80f4779961cdc71');

    return response.data['articles'];
  }
}
