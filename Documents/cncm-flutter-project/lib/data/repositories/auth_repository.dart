import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/LoginRequest.dart';
import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:cncm_flutter_new/data/services/auth_service.dart';
import 'package:dartz/dartz.dart';


import '../models/RegisterRequest.dart';

abstract class AuthRepository {
   Future<Either<ErrorResponse, LoginResponse>> login({required LoginRequest loginRequest});
   Future<Either<ErrorResponse, LoginResponse>> register({required RegisterRequest registerRequest});
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;
  AuthRepositoryImpl({required this.authService});

  @override
  Future<Either<ErrorResponse, LoginResponse >> login({required LoginRequest loginRequest}) async{
    var response =  await authService.login(loginRequest: loginRequest);
    return response.fold((errorResponse) => Left(errorResponse), (loginResponse) => Right(loginResponse));
  }

  @override
  Future<Either<ErrorResponse, LoginResponse>> register({required RegisterRequest registerRequest}) async {
    var response =  await authService.register(registerRequest: registerRequest);
    return response.fold((errorResponse) => Left(errorResponse), (registerResponse) => Right(registerResponse));
  }

}
