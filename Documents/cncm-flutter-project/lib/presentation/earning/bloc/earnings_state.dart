part of 'earnings_bloc.dart';

abstract class EarningsState extends Equatable {
  const EarningsState();
  
  @override
  List<Object?> get props => [];
}

class EarningsInitial extends EarningsState {}

class EarningsLoading extends EarningsState {}
class EarningsLoaded extends EarningsState {
  final EarningResults earningResults;
  const EarningsLoaded(this.earningResults);

  @override
  List<Object?> get props => [earningResults];
}
class ErrorGettingEarningsData extends EarningsState {
  final ErrorResponse errorResponse;

  const ErrorGettingEarningsData(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class EarningsError extends EarningsState{
  final String message;

  const EarningsError(this.message);

  @override
  List<Object?> get props => [message];
}
