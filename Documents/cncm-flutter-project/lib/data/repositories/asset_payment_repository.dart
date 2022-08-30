import 'dart:io';

import 'package:cncm_flutter_new/data/services/asset_payment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:cncm_flutter_new/data/services/asset_payment_service.dart';
import 'package:cncm_flutter_new/data/services/asset_payment_service.dart';
import 'package:url_launcher/url_launcher.dart';




abstract class AssetPaymentRepository{

Future sendPayment({required String assetId});
  // Future<Either<ErrorResponse,Response>> send();

}

class AssetPaymentImpl extends AssetPaymentRepository{
  final AssetPaymentService assetPaymentService;
  AssetPaymentImpl({required this.assetPaymentService}) ;

  @override
  Future sendPayment({required String assetId}) async{
    var response = await assetPaymentService.sendPayment(assetId: assetId);
    response.fold((error) => error, (makepaymentresponse)async{
      await launchUrl(
          Uri.parse(makepaymentresponse.results),


      );
      // launchUrl(),
    });


  }


}

