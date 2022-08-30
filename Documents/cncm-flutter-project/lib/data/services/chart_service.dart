import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/chart_data.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cncm_flutter_new/core/constants.dart';

import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';

class ChartService{
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500000,
    receiveTimeout: 500000,
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sl<LocalStorageService>().getToken}',
    },));

    Future<Either<ErrorResponse,ChartData>> getChartData(int earningChartIndex) async {
       Response? response;
    try {
       FormData formData =   FormData.fromMap({
         "type": selectedChartType(earningChartIndex)
        });
      response = await dio.post('$baseUrl/users/assets/usage',
         data: formData,
       );
      return Right(ChartData.fromJson(response.data),);
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        return Left(ErrorResponse(message: "Error happen try again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen please try again", fieldErrors: [])));
      }
    }      
    }
}


String selectedChartType(int selectedChartIndex){
  if(selectedChartIndex == 1){
    return 'week';
  }else if(selectedChartIndex ==2){
    return 'month';
  }else if(selectedChartIndex == 3){
    return 'year';
  }else if(selectedChartIndex == 4){
    return 'allyear';
  }
  else{
    return 'week';
  }
}