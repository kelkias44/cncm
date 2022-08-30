import 'dart:convert';

MakePaymentResponse MakePaymentResponseFromJson(String str) => MakePaymentResponse.fromJson(json.decode(str));

String MakePaymentResponseToJson(MakePaymentResponse data) => json.encode(data.toJson());

class MakePaymentResponse {
  MakePaymentResponse({
    required this.message,
    required this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  String results;

  factory MakePaymentResponse.fromJson(Map<String, dynamic> json) => MakePaymentResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: json["results"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results,
  };
}