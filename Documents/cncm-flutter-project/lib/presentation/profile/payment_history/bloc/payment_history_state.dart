part of 'payment_history_bloc.dart';

abstract class PaymentHistoryState extends Equatable {
  const PaymentHistoryState();
}

class PaymentHistoryInitial extends PaymentHistoryState {
  @override
  List<Object> get props => [];
}
class PaymentHistoryLoading extends PaymentHistoryState{
  @override
  List<Object?> get props => [];

}
class PaymentHistoryLoaded extends PaymentHistoryState{
  final List<Payment> payments;

  const PaymentHistoryLoaded(this.payments);
  @override
  List<Object?> get props => [payments];

}
class PaymentHistoryError extends PaymentHistoryState{
  final String message;

  const PaymentHistoryError(this.message);
  @override
  List<Object?> get props => [message];
}