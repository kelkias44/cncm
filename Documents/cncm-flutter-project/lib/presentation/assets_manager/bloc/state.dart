import 'package:equatable/equatable.dart';

import '../../../data/models/AssetResponse.dart';
import '../../../data/models/ErrorResponse.dart';

class AssetManageState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends AssetManageState {}

class LoadingAssets extends AssetManageState {}

class ErrorGettingAssets extends AssetManageState {
  final ErrorResponse errorResponse;

  ErrorGettingAssets(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedAssets extends AssetManageState {
 final AssetResponseResults assetResults;

  LoadedAssets(this.assetResults);

  @override
  List<Object?> get props => [assetResults];
}
class LoadedAssetsEmpty extends AssetManageState {

  final List<AssetData> assetData;

  LoadedAssetsEmpty(this.assetData);

  @override
  List<Object?> get props => [assetData];
}