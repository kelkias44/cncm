// To parse this JSON data, do
// final userSearchResponse = userSearchResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


class UserSearchResponse {
  UserSearchResponse({
    required this.message,
    required this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  UserSearchResults results;

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) => UserSearchResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: UserSearchResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}

class UserSearchResults {
  UserSearchResults({
    required this.count,
    required this.searchedUsers,
  });

  int count;
  List<SearchedUsers> searchedUsers;

  factory UserSearchResults.fromJson(Map<String, dynamic> json) => UserSearchResults(
    count: json["count"],
    searchedUsers: List<SearchedUsers>.from(json["rows"].map((x) => SearchedUsers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": List<dynamic>.from(searchedUsers.map((x) => x.toJson())),
  };
}

class SearchedUsers {
  SearchedUsers({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.title,
    required this.username,
    required this.phone,
    required this.email,
    required this.role,
    required this.gender,
    required this.birthdate,
    required this.bank,
    required this.accountNumber,
    required this.representative,
    required this.status,
    required this.picture,
    required this.prefixCode,
    required this.createdAt,
  });

  String id;
  String firstName;
  String middleName;
  String lastName;
  String title;
  String username;
  String phone;
  String email;
  String role;
  String gender;
  DateTime birthdate;
  String bank;
  String accountNumber;
  String representative;
  String status;
  String picture;
  dynamic prefixCode;
  DateTime createdAt;

  factory SearchedUsers.fromJson(Map<String, dynamic> json) => SearchedUsers(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    title: json["title"],
    username: json["username"],
    phone: json["phone"],
    email: json["email"],
    role: json["role"],
    gender: json["gender"],
    birthdate: DateTime.parse(json["birthdate"]),
    bank: json["bank"],
    accountNumber: json["account_number"],
    representative: json["representative"],
    status: json["status"],
    picture: json["picture"],
    prefixCode: json["prefix_code"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "title": title,
    "username": username,
    "phone": phone,
    "email": email,
    "role": role,
    "gender": gender,
    "birthdate": birthdate.toIso8601String(),
    "bank": bank,
    "account_number": accountNumber,
    "representative": representative,
    "status": status,
    "picture": picture,
    "prefix_code": prefixCode,
    "createdAt": createdAt.toIso8601String(),
  };
}
