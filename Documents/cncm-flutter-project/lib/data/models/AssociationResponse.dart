// To parse this JSON data, do
//
//     final associationsResponse = associationsResponseFromJson(jsonString);

import 'dart:convert';

AssociationsResponse associationsResponseFromJson(String str) => AssociationsResponse.fromJson(json.decode(str));

String associationsResponseToJson(AssociationsResponse data) => json.encode(data.toJson());

class AssociationsResponse {
  AssociationsResponse({
    required this.message,
    required  this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  AssociationResults results;

  factory AssociationsResponse.fromJson(Map<String, dynamic> json) => AssociationsResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: AssociationResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}

class AssociationResults {
  AssociationResults({
    required  this.count,
    required  this.associationsData,
  });

  int count;
  AssociationsData associationsData;

  factory AssociationResults.fromJson(Map<String, dynamic> json) => AssociationResults(
    count: json["count"],
    associationsData: AssociationsData.fromJson(json["rows"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": associationsData.toJson(),
  };
}

class AssociationsData {
  AssociationsData({
    required this.id,
    required this.name,
    required this.associations,
  });

  String id;
  String name;
  List<Association> associations;

  factory AssociationsData.fromJson(Map<String, dynamic> json) => AssociationsData(
    id: json["id"],
    name: json["name"],
    associations: List<Association>.from(json["associations"].map((x) => Association.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "associations": List<dynamic>.from(associations.map((x) => x.toJson())),
  };
}

class Association {
  Association({
   required this.id,
    required this.name,
    required this.address,
    required this.licenseNumber,
    required  this.phone,
    required  this.email,
    required  this.licenseDocument,
  });

  String id;
  String name;
  String address;
  String licenseNumber;
  String phone;
  String email;
  String licenseDocument;

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    licenseNumber: json["licenseNumber"],
    phone: json["phone"],
    email: json["email"],
    licenseDocument: json["licenseDocument"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "licenseNumber": licenseNumber,
    "phone": phone,
    "email": email,
    "licenseDocument": licenseDocument,
  };
}
