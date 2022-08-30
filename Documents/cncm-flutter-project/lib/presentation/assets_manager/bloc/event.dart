import 'package:equatable/equatable.dart';


abstract class AssetManageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAssets extends AssetManageEvent {}