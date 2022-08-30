part of 'payment_history_bloc.dart';

abstract class PaymentHistoryEvent extends Equatable {
  const PaymentHistoryEvent();
}

class onLoadedPaymentHistory extends PaymentHistoryEvent{
  @override
  List<Object?> get props => [];

}
