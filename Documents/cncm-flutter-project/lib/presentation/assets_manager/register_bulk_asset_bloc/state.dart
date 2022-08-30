
import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';
 import '../../../data/models/AssetRegistrationRequest.dart';


abstract class RegisterBulkAssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterBulkAssetState {}

class LoadingRegisterBulkAsset extends RegisterBulkAssetState {}

class ErrorRegisterBulkAsset extends RegisterBulkAssetState {
  final ErrorResponse errorResponse;
  ErrorRegisterBulkAsset(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class FieldErrorRegisterBulkAsset extends RegisterBulkAssetState {
  final ErrorResponse errorResponse;
  FieldErrorRegisterBulkAsset(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class RegisteredBulkAssetState extends RegisterBulkAssetState {
  // final AssetRegistrationRequest assetData;
  //
  // RegisteredAssetState(this.assetData);
  //
  // @override
  // List<Object?> get props => [assetData];
}


