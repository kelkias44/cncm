import 'package:equatable/equatable.dart';

abstract class NewFeedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNewsFeed extends NewFeedEvent {}
