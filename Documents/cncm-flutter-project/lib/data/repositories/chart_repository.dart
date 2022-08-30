import 'package:cncm_flutter_new/data/models/chart_data.dart';
import 'package:cncm_flutter_new/data/services/chart_service.dart';
import 'package:dartz/dartz.dart';
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';


abstract class ChartRepository{
  Future<Either<ErrorResponse, ChartData>> getChartData(int earningChartindex);
}


class ChartRepositoryImpl implements ChartRepository{
  final ChartService chartService ;
  ChartRepositoryImpl({required this.chartService});
  @override
  Future<Either<ErrorResponse, ChartData>> getChartData(int earningChartindex) async {
    var response = await chartService.getChartData(earningChartindex);
    return response.fold((errorresponse) => Left(errorresponse),(chartData) => Right(chartData));
     }
  
}