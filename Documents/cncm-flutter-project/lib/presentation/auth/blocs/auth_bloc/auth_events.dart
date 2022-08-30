import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendAuthData extends AuthEvent {
  final String username;
  final String password;

  SendAuthData({required this.username, required this.password});
  @override
  List<Object?> get props => [username, password];
}

class CheckAuthOnStartUp extends AuthEvent {}

class RegisterUser extends AuthEvent {
  final String password;
  final String email;

  RegisterUser({required this.password, required this.email});
  @override
  List<Object?> get props => [ password, email];
}

class NoInternetEvent extends AuthEvent {}