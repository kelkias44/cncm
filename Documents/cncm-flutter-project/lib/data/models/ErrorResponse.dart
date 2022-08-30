// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    required this.message,
    required this.code,
    required this.error,
    required this.errors,
  });

  String message;
  int code;
  bool error;
  ErrorsMessage errors;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"],
    code: json["code"],
    error: json["error"],
    errors: ErrorsMessage.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "errors": errors.toJson(),
  };
}

class ErrorsMessage {
  ErrorsMessage({
    required  this.errorCode,
    required  this.errorMessage,
    required this.fieldErrors,
  });

  int errorCode;
  String errorMessage;
  List<dynamic> fieldErrors;

  factory ErrorsMessage.fromJson(Map<String, dynamic> json) => ErrorsMessage(
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"],
    fieldErrors: List<dynamic>.from(json["fieldErrors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "errorCode": errorCode,
    "errorMessage": errorMessage,
    "fieldErrors": List<dynamic>.from(fieldErrors.map((x) => x)),
  };
}
