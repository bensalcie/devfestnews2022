part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

/// Call this event to trigger an API call to the news api from the UI.
class GetNews extends NewsEvent {}
