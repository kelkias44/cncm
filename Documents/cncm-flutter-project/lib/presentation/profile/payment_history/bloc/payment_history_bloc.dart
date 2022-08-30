import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/models/payment_history_model.dart';
import 'package:cncm_flutter_new/data/repositories/membership_payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payment_history_event.dart';
part 'payment_history_state.dart';

class PaymentHistoryBloc extends Bloc<PaymentHistoryEvent, PaymentHistoryState> {
  final MembershipPaymentRepository membershipPaymentRepository;
  PaymentHistoryBloc(this.membershipPaymentRepository) : super(PaymentHistoryInitial()) {
    on<PaymentHistoryEvent>((event, emit)async{
      if(event is onLoadedPaymentHistory) {
        emit(PaymentHistoryLoading());
        var data = await membershipPaymentRepository.getPaymentHistory();
        data.fold(
          (error) =>emit(PaymentHistoryError(error.message)) ,
          (responseData) => emit(PaymentHistoryLoaded(responseData.results.rows.payments)));
      }
    });
  }
}
