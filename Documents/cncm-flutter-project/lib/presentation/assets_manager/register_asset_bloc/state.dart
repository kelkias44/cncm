
import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';
 import '../../../data/models/AssetRegistrationRequest.dart';


abstract class RegisterAssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterAssetState {}

class LoadingRegisterAsset extends RegisterAssetState {}

class ErrorRegisterAsset extends RegisterAssetState {
  final ErrorResponse errorResponse;
  ErrorRegisterAsset(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class FieldErrorRegisterAsset extends RegisterAssetState {
  final ErrorResponse errorResponse;
  FieldErrorRegisterAsset(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class RegisteredAssetState extends RegisterAssetState {
  // final AssetRegistrationRequest assetData;
  //
  // RegisteredAssetState(this.assetData);
  //
  // @override
  // List<Object?> get props => [assetData];
}


