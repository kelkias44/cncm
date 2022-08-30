// To parse this JSON data, do
//
//     final registerRequest = registerRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

RegisterRequest registerRequestFromJson(String str) => RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) => json.encode(data.toJson());

class RegisterRequest {
  RegisterRequest({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.gender,
    required this.bank,
    required this.accountNumber,
    required this.representative,
    required this.role,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.picture,
    required this.associationId,
    required this.title,
  });

  String firstName;
  String middleName;
  String lastName;
  String email;
  String phone;
  String birthdate;
  String gender;
  String bank;
  String accountNumber;
  String representative;
  String role;
  String username;
  String password;
  String confirmPassword;
  File picture;
  String associationId;
  String title;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    birthdate: json["birthdate"],
    gender: json["gender"],
    bank: json["bank"],
    accountNumber: json["account_number"],
    representative: json["representative"],
    role: json["role"],
    username: json["username"],
    password: json["password"],
    confirmPassword: json["confirm_password"],
    picture: json["picture"],
    associationId: json["associationId"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "birthdate": birthdate,
    "gender": gender,
    "bank": bank,
    "account_number": accountNumber,
    "representative": representative,
    "role": role,
    "username": username,
    "password": password,
    "confirm_password": confirmPassword,
    "picture": picture,
    "associationId": associationId,
    "title": title,
  };
}
