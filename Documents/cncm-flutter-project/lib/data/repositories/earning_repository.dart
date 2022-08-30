import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/earning_response.dart';
import 'package:cncm_flutter_new/data/services/earning_services.dart';
import 'package:dartz/dartz.dart';

abstract class EarningRepository{
  Future<Either<ErrorResponse, EarningData>> getEarningData();
}
class EarningRepositoryImpl implements EarningRepository{
  final EarningService earningService ;
  EarningRepositoryImpl({required this.earningService});
  @override
  Future<Either<ErrorResponse, EarningData>> getEarningData()async{
    var response = await earningService.getEarningData();
    return response.fold((errorresponse) => Left(errorresponse),(earnData) => Right(earnData));
     }    
  }

