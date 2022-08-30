
import 'dart:convert';

MembershipPaymentResponse membershipPaymentResponseFromJson(String str) => MembershipPaymentResponse.fromJson(json.decode(str));

String membershipPaymentResponseToJson(MembershipPaymentResponse data) => json.encode(data.toJson());

class MembershipPaymentResponse {
  MembershipPaymentResponse({
   required this.message,
   required this.error,
   required this.code,
   required this.results,
  });

  String message;
  bool error;
  int code;
  MembershipPaymentResults results;

  factory MembershipPaymentResponse.fromJson(Map<String, dynamic> json) => MembershipPaymentResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: MembershipPaymentResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}

class MembershipPaymentResults {
  MembershipPaymentResults({
   required this.userPayments,
  });

  List<UserPayment> userPayments;

  factory MembershipPaymentResults.fromJson(Map<String, dynamic> json) => MembershipPaymentResults(
    userPayments: List<UserPayment>.from(json["user-payments"].map((x) => UserPayment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user-payments": List<dynamic>.from(userPayments.map((x) => x.toJson())),
  };
}

class UserPayment {
  UserPayment({
   required this.id,
   required this.value,
   required this.name,
   required this.type,
   required this.status,
   required this.createdAt,
  });

  String id;
  String value;
  String name;
  String type;
  String status;
  DateTime createdAt;

  factory UserPayment.fromJson(Map<String, dynamic> json) => UserPayment(
    id: json["id"],
    value: json["value"],
    name: json["name"],
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "name": name,
    "type": type,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
  };
}
