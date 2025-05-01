part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsItemEntity> newsItems;

  const NewsLoadedState(this.newsItems);

  @override
  List<Object> get props => [newsItems];
}

class NewsErrorState extends NewsState {
  final String message;

  const NewsErrorState(this.message);

  @override
  List<Object> get props => [message];
}
