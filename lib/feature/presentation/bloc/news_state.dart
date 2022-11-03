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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'articles': articles,
      'status': status.index,
    };
  }

  factory NewsState.fromMap(Map<String, dynamic> map) {
    int val = map['status'];
    return NewsState(
      articles: List.from((map['articles'] as List)),
      status: NewsStatus.values[val],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsState.fromJson(String source) =>
      NewsState.fromMap(json.decode(source) as Map<String, dynamic>);
}



enum NewsStatus { initial, loading, loaded, error }
