import 'dart:async';
import 'dart:convert';

import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/data/models/ErrorResponse.dart';
import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:cncm_flutter_new/data/models/RegisterRequest.dart';
import 'package:cncm_flutter_new/presentation/common/extension/range_number.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/LoginRequest.dart';


class AuthService {
  Dio dio = Dio(BaseOptions(
    connectTimeout: 500000,
    receiveTimeout: 500000,
    headers: {

      "Content-Type": "application/json",
    },
  ));

  Future<Either<ErrorResponse, LoginResponse>> login(
      {required LoginRequest loginRequest}) async {
    Response? response;


    try {
      response = await dio.post(
        '$baseUrl/auth/login',
        data: loginRequest.toJson(),
      );
      return Right(LoginResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        debugPrint("Error response from decode: ");
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        debugPrint("Error from login $e");
        return Left(ErrorResponse(message: "Error happen please try again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen please try again", fieldErrors: [])));
      }
    }
  }
  Future<Either<ErrorResponse, LoginResponse>> register({required RegisterRequest registerRequest}) async {

    var headers = {
      'Authorization': 'notoken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/register'));
    request.fields.addAll({
      'first_name': registerRequest.firstName,
      'middle_name': registerRequest.middleName,
      'last_name': registerRequest.lastName,
      'email': registerRequest.email,
      'phone': registerRequest.phone,
      'birthdate': registerRequest.birthdate,
      'gender': registerRequest.gender,
      'bank': registerRequest.bank,
      'account_number': registerRequest.accountNumber,
      'representative': registerRequest.accountNumber,
      'username': registerRequest.username,
      'password': registerRequest.password,
      'confirm_password': registerRequest.confirmPassword,
      'associationId': registerRequest.associationId,
      'title': registerRequest.title,
    });
    request.files.add(await http.MultipartFile.fromPath('picture', registerRequest.picture.path));
    request.headers.addAll(headers);
    debugPrint('file path: ');
    debugPrint(registerRequest.picture.path);
    http.Response? response;
    try {

      http.Response response = await http.Response.fromStream(await request.send());
      if (response.statusCode.isBetween(200, 299)) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint(result.toString());
        return Right(LoginResponse.fromJson(result));
      } else {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint(result.toString());
        return Left(ErrorResponse.fromJson(result));
      }
    }  catch (e)  {
        debugPrint('error from the register page');
        debugPrint(e.toString());
       return Left(ErrorResponse(message: "Error happen while registering please try again!", error: true, code: 401, errors: ErrorsMessage(errorCode: 404, errorMessage: "error happen", fieldErrors: [])));
    
    }
  }
}


