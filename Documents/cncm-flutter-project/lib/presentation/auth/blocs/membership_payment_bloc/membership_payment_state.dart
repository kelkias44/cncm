part of 'membership_payment_bloc.dart';

class MembershipPaymentState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends MembershipPaymentState {}

class LoadingMembershipPayment extends MembershipPaymentState {}

class ErrorGettingMembershipPayment extends MembershipPaymentState {
  final ErrorResponse errorResponse;

  ErrorGettingMembershipPayment(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class LoadedMembershipPayment extends MembershipPaymentState {
  final List<UserPayment> userPayments;

  LoadedMembershipPayment(this.userPayments);

  @override
  List<Object?> get props => [userPayments];
}
class LoadedMembershipPaymentEmpty extends MembershipPaymentState {
  final List<UserPayment> userPayments;

  LoadedMembershipPaymentEmpty(this.userPayments);

  @override
  List<Object?> get props => [userPayments];
}