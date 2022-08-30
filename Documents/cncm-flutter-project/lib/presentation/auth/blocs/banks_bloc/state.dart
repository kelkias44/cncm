

import 'package:cncm_flutter_new/data/models/BanksResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';

class BanksState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends BanksState {}

class LoadingBanks extends BanksState {}

class ErrorGettingBanks extends BanksState {
  final ErrorResponse errorResponse;
  ErrorGettingBanks(this.errorResponse);
  @override
  List<Object?> get props => [errorResponse];
}

class LoadedBanks extends BanksState {
  final List<Bank> banks;
  LoadedBanks(this.banks);
  @override
  List<Object?> get props => [banks];
}
class LoadedBankEmpty extends BanksState {
  final List<Bank> banks;

  LoadedBankEmpty(this.banks);

  @override
  List<Object?> get props => [banks];
}