import 'package:equatable/equatable.dart';

import '../../../../data/models/ErrorResponse.dart';
import '../../../../data/models/LoginUser.dart';


abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends RegisterState {}

class LoadingRegister extends RegisterState {}

class ErrorRegister extends RegisterState {
  final ErrorResponse errorResponse;
  ErrorRegister(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class FieldErrorRegister extends RegisterState {
  final ErrorResponse errorResponse;
  FieldErrorRegister(this.errorResponse);

  @override
  List<Object?> get props => [errorResponse];
}
class RegisteredState extends RegisterState {
  final User authData;

  RegisteredState(this.authData);

  @override
  List<Object?> get props => [authData];
}


