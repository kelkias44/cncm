import 'package:cncm_flutter_new/data/models/UnreadNotificationResponse.dart';
import 'package:dartz/dartz.dart';
import '../models/ErrorResponse.dart';
import '../models/NotificationResponse.dart';
import '../services/notification_service.dart';
import 'package:dio/dio.dart';


abstract class NotificationRepository {
  NotificationRepository(Object object);

  Future<Either<ErrorResponse,NotificationResponse>> getNotification();
  Future<Either<ErrorResponse,UnreadNotificationResponse>> getUnread();
  Future<Either<ErrorResponse,Response>> getMarkRead();

}

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationServiece notificationServiece;

  NotificationRepositoryImpl({
    required this.notificationServiece,
  }) : super(notificationServiece);

  @override
  Future<Either<ErrorResponse, NotificationResponse>> getNotification() async{
    var response = await notificationServiece.getNotification();
    return response.fold((errorResponse) => Left(errorResponse), 
    (notificationResponse) => Right(notificationResponse));
  }

  @override
  Future<Either<ErrorResponse, UnreadNotificationResponse>> getUnread() async{
    var response = await notificationServiece.getUnread();
    return response.fold((errorResponse) => Left(errorResponse), 
    (notificationResponse) => Right(notificationResponse));

  }

  @override
  Future<Either<ErrorResponse, Response>> getMarkRead() async{
    var response = await notificationServiece.getMarkRead();
    return response.fold((errorResponse) => Left(errorResponse), 
    (notificationResponse) => Right(notificationResponse));
  
  }
}
