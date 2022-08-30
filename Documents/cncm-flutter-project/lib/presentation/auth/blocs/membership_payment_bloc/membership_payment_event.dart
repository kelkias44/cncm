part of 'membership_payment_bloc.dart';



abstract class MembershipPaymentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class LoadMembershipPayment extends MembershipPaymentEvent {}

