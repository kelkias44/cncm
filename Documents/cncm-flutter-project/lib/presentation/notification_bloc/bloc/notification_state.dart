
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/NotificationResponse.dart';



abstract class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class LoadingNotification extends NotificationState{}

class ErrorGettingNotification extends NotificationState {
  final ErrorResponse errorNotificationResponse;
  ErrorGettingNotification({
    required this.errorNotificationResponse,
  });
  @override
  List<Object> get props => [errorNotificationResponse];
}

class LoadedNotification extends NotificationState {
  final Results notificationResults;

  LoadedNotification({
    required this.notificationResults,
  });

    
  @override
  List<Object> get props => [notificationResults];
}



class LoadedNotificationEmpty extends NotificationState {
  List<Row> row;
  LoadedNotificationEmpty({
    required this.row,
  });

  @override
  List<Object> get props => [row];
}
