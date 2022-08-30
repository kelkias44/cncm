import 'package:cncm_flutter_new/data/models/RegisterRequest.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUser extends RegisterEvent {
  final RegisterRequest registerRequest;
  RegisterUser({required this.registerRequest});
}

