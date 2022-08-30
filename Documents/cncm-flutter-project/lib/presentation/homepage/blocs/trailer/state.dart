import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';

class TrailerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends TrailerState {}
class LoadingTrailer extends TrailerState{}

class ErrorGettingTrailer extends TrailerState{
  final ErrorResponse errorResponse;
  ErrorGettingTrailer(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedTrailer extends TrailerState {
  final List<NewsFeed> newsFeed;
  LoadedTrailer(this.newsFeed);

  @override
  List<Object?> get props => [newsFeed];
}
class LoadedTrailerEmpty extends TrailerState {
  final List<NewsFeed> newsFeed;
  LoadedTrailerEmpty(this.newsFeed);

  @override
  List<Object?> get props => [newsFeed];
}

