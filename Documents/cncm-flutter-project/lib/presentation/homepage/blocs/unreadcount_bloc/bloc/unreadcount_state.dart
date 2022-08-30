part of 'unreadcount_bloc.dart';

@immutable
abstract class UnreadcountState {}

class UnreadcountInitial extends UnreadcountState {}

class LoadingUnreadNotification extends UnreadcountState{}

class ErrorGettingUnreadNotification extends UnreadcountState{}

class LoadedUnreadNotification extends UnreadcountState {
  final Results notificationResults;

  LoadedUnreadNotification({
    required this.notificationResults,
  });
@override
  List<Object> get props => [notificationResults];
}
