import 'dart:convert';

MakePaymentResonse makePaymentResonseFromJson(String str) => MakePaymentResonse.fromJson(json.decode(str));

String makePaymentResonseToJson(MakePaymentResonse data) => json.encode(data.toJson());

class MakePaymentResonse {
  MakePaymentResonse({
    required this.message,
    required this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  String results;

  factory MakePaymentResonse.fromJson(Map<String, dynamic> json) => MakePaymentResonse(
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
