
import 'package:cncm_flutter_new/data/models/AssetRegistrationRequest.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterAssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterAsset extends RegisterAssetEvent {
  final AssetRegistrationRequest assetRegistrationRequest;
  RegisterAsset({required this.assetRegistrationRequest});
}

