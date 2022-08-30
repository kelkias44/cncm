import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/models/MembershipPaymentResponse.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';
import '../../../../data/repositories/department_repository.dart';

part 'membership_payment_event.dart';
part 'membership_payment_state.dart';



class MembershipPaymentBloc extends Bloc<MembershipPaymentEvent, MembershipPaymentState> {
  DepartmentRepository departmentRepository;

  MembershipPaymentBloc(this.departmentRepository) : super(InitialState()) {
    on<MembershipPaymentEvent>((event, emit) async {
      if (event is LoadMembershipPayment) {
        emit(LoadingMembershipPayment());
        var paymentResponse = await departmentRepository.getMembershipPayment();
        paymentResponse.fold((error) => emit(ErrorGettingMembershipPayment(error)),
                (paymentResponse) async {

              emit(LoadedMembershipPayment(paymentResponse.results.userPayments));
            });
      }
    });
  }
}
