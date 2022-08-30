part of 'earnings_bloc.dart';

abstract class EarningsEvent extends Equatable {
  const EarningsEvent();

  @override
  List<Object> get props => [];
}

class EarningOnLoad extends EarningsEvent{}
