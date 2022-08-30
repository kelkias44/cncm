import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/PyamentResponse.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';

// const String baseUrl = 'https://api.a2p.et:5666/cmo/api/v1';

const String baseUrl = 'http://192.168.0.112:8081/cmo/api/v1';

class AssetPaymentService{
  Dio dio = Dio(
      BaseOptions(
          connectTimeout:50000000,
          receiveTimeout: 50000000,
          headers: {
            'Authorization':
            'Bearer ${sl<LocalStorageService>().getToken}',
            "Content-Type": "application/json",
          }

      )
  );

  Future<Either<ErrorResponse,MakePaymentResponse>> sendPayment({required String assetId}) async{
    Response? response;
    String? userId = await sl<LocalStorageService>().getStringFromDisk('userId');
    try{
        response = await dio.post(
          '$baseUrl/users/$userId/payments/make-payment/sdk',
           data: {
             "type":"ASSET-ACTIVATION",
             "assetId":assetId,
             "amount":1,
             "method":"sdk"
           });
        return Right(MakePaymentResponse.fromJson(response.data));

    }catch(e){
      if(e is DioError){
        return Left(ErrorResponse.fromJson(response?.data));
      }else{
        throw Exception("Error");
      }
    }

  }




}