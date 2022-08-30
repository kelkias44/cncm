// To parse this JSON data, do
//
//     final titlesResponse = titlesResponseFromJson(jsonString);

import 'dart:convert';

TitlesResponse titlesResponseFromJson(String str) =>
    TitlesResponse.fromJson(json.decode(str));

String titlesResponseToJson(TitlesResponse data) => json.encode(data.toJson());

class TitlesResponse {
  TitlesResponse({
    required this.message,
    required this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  TitlesResults results;

  factory TitlesResponse.fromJson(Map<String, dynamic> json) => TitlesResponse(
        message: json["message"],
        error: json["error"],
        code: json["code"],
        results: TitlesResults.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "code": code,
        "results": results.toJson(),
      };
}

class TitlesResults {
  TitlesResults({
    required this.contributorRoles,
  });

  List<ContributorRole> contributorRoles;

  factory TitlesResults.fromJson(Map<String, dynamic> json) => TitlesResults(
        contributorRoles: List<ContributorRole>.from(
            json["contributor-roles"].map((x) => ContributorRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contributor-roles":
            List<dynamic>.from(contributorRoles.map((x) => x.toJson())),
      };
}

class ContributorRole {
  ContributorRole({
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

  factory ContributorRole.fromJson(Map<String, dynamic> json) =>
      ContributorRole(
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
