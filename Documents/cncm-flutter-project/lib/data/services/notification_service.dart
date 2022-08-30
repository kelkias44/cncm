
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/UnreadNotificationResponse.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';
import '../models/NotificationResponse.dart';

const String baseUrl = 'https://api.a2p.et:5666/cmo/api/v1';


class NotificationServiece{
  Dio dio = Dio(
    BaseOptions(
      connectTimeout:50000,
      receiveTimeout: 50000,
      headers: {
        'Authorization':
    'Bearer ${sl<LocalStorageService>().getToken}',
    "Content-Type": "application/json",
      }

    )
  );

  Future<Either<ErrorResponse,NotificationResponse>> getNotification() async{
    Response? response;
    try{
      response = await dio.get('$baseUrl/users/notifications');
      return Right(NotificationResponse.fromJson(response.data));
    }catch(e){
      if(e is DioError){

        return Left(ErrorResponse.fromJson(response!.data));
      }else{
        throw Exception("Error");
      }
    }

  }


  Future<Either<ErrorResponse,Response>> getMarkRead() async{
    Response? response;
    try{
      response = await dio.put(
        '$baseUrl/users/notifications/markallread',
        
        );
        return Right(response);

    }catch(e){
      if(e is DioError){
        return Left(ErrorResponse.fromJson(response!.data));
      }else{
        throw Exception("Error");
      }
      }
    

  }
  Future<Either<ErrorResponse,UnreadNotificationResponse>> getUnread() async{
    Response? response;
    try{
      response = await dio.get('$baseUrl/users/notifications/count');
      return Right(UnreadNotificationResponse.fromJson(response.data));
    }catch(e){
      if(e is DioError){
        return Left(ErrorResponse.fromJson(response!.data));
      }else{
        throw Exception("Error");
      }
    }

  }

  
}