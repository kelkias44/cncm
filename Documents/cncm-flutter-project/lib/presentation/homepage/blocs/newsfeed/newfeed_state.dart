import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:equatable/equatable.dart';

abstract class NewsFeedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends NewsFeedState {}

class LoadingNewFeed extends NewsFeedState {}

class ErrorGettingFeeds extends NewsFeedState {
  final ErrorResponse errorResponse;

  ErrorGettingFeeds(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedNewsFeed extends NewsFeedState {
  final List<NewsFeed> newsFeed;

  LoadedNewsFeed(this.newsFeed);

  @override
  List<Object?> get props => [newsFeed];
}
class LoadedNewsFeedEmpty extends NewsFeedState {
  final List<NewsFeed> newsFeed;

  LoadedNewsFeedEmpty(this.newsFeed);

  @override
  List<Object?> get props => [newsFeed];
}