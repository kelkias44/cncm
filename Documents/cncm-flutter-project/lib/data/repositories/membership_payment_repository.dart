import 'package:cncm_flutter_new/data/models/payment_history_model.dart';
import 'package:cncm_flutter_new/data/services/membership_payment_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/ErrorResponse.dart';

abstract class MembershipPaymentRepository{
  Future paymentRequest();
  Future<Either<ErrorResponse,PaymentHistoryModel>> getPaymentHistory();
}

class MembershipPaymentRepositoryImpl implements MembershipPaymentRepository{
  final MembershipPaymentService membershipPaymentService;

  MembershipPaymentRepositoryImpl(this.membershipPaymentService);
  @override
  Future paymentRequest() async {
    var response = await membershipPaymentService.paymentRequest();
    response.fold((error) => error, (makepaymentresponse)async{
      
      final flutterWebviewPlugnin = FlutterWebviewPlugin();
      flutterWebviewPlugnin.launch(
          makepaymentresponse.results,
        withLocalUrl: true,
        ignoreSSLErrors: true
      );
      // launchUrl(
      // Uri.parse(makepaymentresponse.results)
      // );

    });
  }
  
  @override
  Future<Either<ErrorResponse,PaymentHistoryModel>> getPaymentHistory()async{
    var response = await membershipPaymentService.getPaymentHistory();
    return response.fold((error) => Left(error), (responseData) => Right(responseData));   
  }
}