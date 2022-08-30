
import 'dart:developer';

import 'package:cncm_flutter_new/data/models/AssetResponse.dart';
import 'package:cncm_flutter_new/data/models/BulkAssetRequest.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../core/constants.dart';
import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';
import '../models/AssetRegistrationRequest.dart';
import '../models/ErrorResponse.dart';

class AssetService {
Dio dio = Dio(BaseOptions(
  connectTimeout: 5000000,
  receiveTimeout: 5000000,
  headers: {
    'Authorization':
    'Bearer ${sl<LocalStorageService>().getToken}',
    "Content-Type": "application/json",
  },
));


Future<Either<ErrorResponse, AssetResponse>> getAssets() async {
  Response? response;
  debugPrint('ASSET IS CALLED IN SERVICE');
  String? userId = await sl<LocalStorageService>().getStringFromDisk('userId');
  debugPrint("User Id: $userId");
  try {
    response = await dio.get('$baseUrl/users/$userId/assets');
    debugPrint('the response from get asset:${response.data}');
    return Right(AssetResponse.fromJson(response.data));
  } catch (e) {
    if (e is DioError) {
      debugPrint(e.response?.data);
      return Left(ErrorResponse.fromJson(e.response?.data));
    } else {
      debugPrint('some error from asset -----');
      debugPrint(e.toString());
      return Left(ErrorResponse(message: "Error happen while getting asset please refresh it again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen please try again", fieldErrors: [])));
    }
  }
}

Future<Either<ErrorResponse, Response>> postAsset(
      {required AssetRegistrationRequest asset}) async {
  Response? response;
  debugPrint('asset registration is called in service');
  String? userId = await sl<LocalStorageService>().getStringFromDisk('userId');
  try {
    log(asset.toJson().toString());
    response = await dio.post('$baseUrl/users/$userId/assets', data: asset.toJson(),);
    debugPrint('the response from register  asset');
    return Right(response);
  } catch (e) {
    if (e is DioError) {
      log('error from dio asset');
      debugPrint(e.response.toString());
      return Left(ErrorResponse.fromJson(e.response?.data));
    } else {
      log("Registering asset error");
      log(e.toString());
      return Left(ErrorResponse(message: "Error happen while registering asset please try again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen please try again", fieldErrors: [])));
    }
  }
}

Future<Either<ErrorResponse, Response>> postBulkAsset(
    {required BulkAssetRegistrationRequest asset}) async {
  Response? response;
  debugPrint('bulk asset registration is called in service');
  String? userId = await sl<LocalStorageService>().getStringFromDisk('userId');
  try {
    log(asset.toJson().toString());
    response = await dio.post('$baseUrl/users/$userId/assets', data: asset.toJson());
    debugPrint('the response from register bulk  asset');
    return Right(response);
  } catch (e) {
    if (e is DioError) {
      debugPrint(e.response.toString());
      return Left(ErrorResponse.fromJson(e.response?.data));
    } else {
      return Left(ErrorResponse(message: "Error happen while registering bulk asset please try again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen please try again", fieldErrors: [])));


    }
  }
}

}