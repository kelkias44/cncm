
import 'package:cncm_flutter_new/data/models/AssetRegistrationRequest.dart';
import 'package:cncm_flutter_new/data/models/AssetResponse.dart';
import 'package:cncm_flutter_new/data/models/BulkAssetRequest.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/ErrorResponse.dart';
import '../services/asset_service.dart';

abstract class AssetRepository {
  Future<Either<ErrorResponse, AssetResponse>> getAssets();
  Future<Either<ErrorResponse, Response>> postAssets({required AssetRegistrationRequest asset});
  Future<Either<ErrorResponse, Response>> postBulkAssets({required BulkAssetRegistrationRequest asset});
}

class AssetRepositoryImpl extends AssetRepository {
  final AssetService assetService;
  AssetRepositoryImpl({required this.assetService});

  ///this one loads [assetLists]
  @override
  Future<Either<ErrorResponse, AssetResponse>> getAssets()async {
    var response = await assetService.getAssets();
    return response.fold((errorResponse) => Left(errorResponse), (
        assetResponse) => Right(assetResponse));
  }

  @override
  Future<Either<ErrorResponse, Response>> postAssets({required AssetRegistrationRequest asset}) async {
    var response = await assetService.postAsset(asset: asset);

    return response.fold((errorResponse) => Left(errorResponse), (
        assetResponse) => Right(assetResponse));
  }

  @override
  Future<Either<ErrorResponse, Response>> postBulkAssets({required BulkAssetRegistrationRequest asset}) async{
    var response = await assetService.postBulkAsset(asset: asset);

    return response.fold((errorResponse) => Left(errorResponse), (
        assetResponse) => Right(assetResponse));
  }
}