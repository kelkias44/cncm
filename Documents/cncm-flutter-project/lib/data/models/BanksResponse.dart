// To parse this JSON data, do
//
//     final banksResponse = banksResponseFromJson(jsonString);

import 'dart:convert';

BanksResponse banksResponseFromJson(String str) => BanksResponse.fromJson(json.decode(str));

String banksResponseToJson(BanksResponse data) => json.encode(data.toJson());

class BanksResponse {
  BanksResponse({
    required  this.message,
    required  this.error,
    required  this.code,
    required  this.results,
  });

  String message;
  bool error;
  int code;
  BankResults results;

  factory BanksResponse.fromJson(Map<String, dynamic> json) => BanksResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: BankResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}

class BankResults {
  BankResults({
    required  this.banks,
  });

  List<Bank> banks;

  factory BankResults.fromJson(Map<String, dynamic> json) => BankResults(
    banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
  };
}

class Bank {
  Bank({
    required this.id,
    required  this.value,
    required this.name,
    required this.type,
    required  this.status,
    required  this.createdAt,
  });

  String id;
  String value;
  String name;
  String type;
  String status;
  DateTime createdAt;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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
