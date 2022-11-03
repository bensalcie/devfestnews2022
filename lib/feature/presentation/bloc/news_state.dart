part of 'news_bloc.dart';

class NewsState extends Equatable {
  final List articles;
  final NewsStatus status;

  const NewsState({this.articles = const [], this.status = NewsStatus.initial});

  NewsState copyWith({
    List? articles,
    NewsStatus? status,
  }) {
    return NewsState(
      articles: articles ?? this.articles,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [articles, status];
}

enum NewsStatus { initial, loading, loaded, error }
