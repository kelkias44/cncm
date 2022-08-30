import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends AuthState {}

class SendingAuthData extends AuthState {}

class ErrorSendingAuthData extends AuthState {
  final ErrorResponse errorResponse;

  ErrorSendingAuthData(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}

class AuthenticatedState extends AuthState {
  final User authData;

  AuthenticatedState(this.authData);

  @override
  List<Object?> get props => [authData];
}

class CheckingAuth extends AuthState {}

class AuthNoInternetState extends AuthState {}