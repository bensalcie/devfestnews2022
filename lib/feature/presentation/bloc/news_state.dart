part of 'news_bloc.dart';

class NewsState extends Equatable {
  final List articles;

  const NewsState({this.articles = const []});

  @override
  List<Object> get props => [];
}

enum NewsStatus { initial, loading, loaded, error }
