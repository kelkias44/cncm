import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/core/util/local_storage_service.dart';
import 'package:cncm_flutter_new/data/models/PyamentResponse.dart';
import 'package:cncm_flutter_new/data/models/payment_history_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../service_locator.dart';
import '../models/ErrorResponse.dart';

class MembershipPaymentService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500000,
    receiveTimeout: 500000,
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${sl<LocalStorageService>().getToken}',
    },
  ));

  Future<Either<ErrorResponse, MakePaymentResponse>> paymentRequest() async {
    Response? response;
    String? userId =
        await sl<LocalStorageService>().getStringFromDisk('userId');
    try {
      response = await dio.post(
          baseUrl + "/users/$userId/payments/make-payment/sdk",
          data: {'type': 'MEMBERSHIP', 'method': 'sdk', 'amount': 1});
      // print(response.data);
      return Right(MakePaymentResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        print('response: ${response?.data}');
        return Left(ErrorResponse.fromJson(response?.data));
      } else {
        print('response from payment request: $e');

        throw Exception("Error");
      }
    }
  }

  Future<Either<ErrorResponse, PaymentHistoryModel>> getPaymentHistory() async {
    Response? response;
    String? userId =
        await sl<LocalStorageService>().getStringFromDisk('userId');
    try {
      response = await dio.get('$baseUrl/users/$userId/payments');
      return Right(PaymentHistoryModel.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(response?.data));
      } else {
        throw Exception('error');
      }
    }
  }
}
