
import 'package:cncm_flutter_new/data/models/AssetRegistrationRequest.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/BulkAssetRequest.dart';

abstract class RegisterBulkAssetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterBulkAsset extends RegisterBulkAssetEvent {
  final BulkAssetRegistrationRequest assetRegistrationRequest;
  RegisterBulkAsset({required this.assetRegistrationRequest});
}

