import 'package:equatable/equatable.dart';

abstract class BanksEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadBanks extends BanksEvent {}