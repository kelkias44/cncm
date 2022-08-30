import 'package:cncm_flutter_new/core/api_util/ApiBaseHelper.dart';
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/earning_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';

class EarningService{
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500000,
    receiveTimeout: 500000,
    headers: {
      'Authorization': 'Bearer ${sl<LocalStorageService>().getToken}',
      "Content-Type": "application/json",

    },));


    Future<Either<ErrorResponse,EarningData>> getEarningData()async{
      Response? response;
    try {
      // response = await dio.post('$baseUrl/users/invoices/aggregate');
      sl<ApiBaseHelper>().postHTTP('/users/invoices/aggregate',null);
      return Right(EarningData.fromJson(response!.data),);
    } catch (e) {
      if (e is DioError) {

        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {

        throw Exception("Error");
      }
    }            
    }
}