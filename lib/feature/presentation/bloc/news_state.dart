part of 'news_bloc.dart';

/// [NewsState] Bloc state for news that are shown on the app.
///
/// It contains a [List] of articles fetched from the news api and [NewsStatus]

class NewsState extends Equatable {
  /// [List] of articles loaded from the api set to empty list in [NewsState]
  /// constructor until theres news to show from the api.
  final List articles;

  /// [NewsStatus] enum value of the bloc state. Represents what the current
  /// state of the app in regards to the API data fetch.
  final NewsStatus status;

  const NewsState({this.articles = const [], this.status = NewsStatus.initial});

  /// Helps to easily change the values that changed from a certain state change
  /// Values will be changed only if they are provided.
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

  /// Creates a [Map<String, dynamic>] from the properties of NewsState class.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'articles': articles,
      'status': status.index,
    };
  }

  /// Factory method that return converts back [NewsState] class Map data to its
  /// respective [NewsState] class.
  factory NewsState.fromMap(Map<String, dynamic> map) {
    // Get the index of the set [enum] value.
    int index = map['status'];

    return NewsState(
      articles: List.from((map['articles'] as List)),
      status: NewsStatus.values[index], //  Map back to [enum] type.
    );
  }

  /// Encodes the [NewsState] Map representation to JSON representation of the
  /// class.
  String toJson() => json.encode(toMap());

  /// Decodes the [NewsState] Map data previously encoded to json back to
  /// [NewsState] class.
  factory NewsState.fromJson(String source) =>
      NewsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

/// [enum] representing states the news api can be in.
///
/// [NewsStatus.initial] this is before an API call is made and there is no data
///
/// [NewsStatus.loading] the app is fetching news from the news api.
///
/// [NewsStatus.loaded] app has finished fetching the data from the api.
///
/// [NewsStatus.error] app has finished featching the data from the api but an
/// error occurred. e.g No internet connection, data serialization failed.
enum NewsStatus { initial, loading, loaded, error }
