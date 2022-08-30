// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';


class LoginResponse {
  LoginResponse({
    required this.message,
    required  this.error,
    required  this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  User results;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: User.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}
class UserDepartment {
  UserDepartment({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory UserDepartment.fromJson(Map<String, dynamic> json) => UserDepartment(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
class UserMembership {
  UserMembership({
    required this.expired,
    required this.remainingDays,
    required this.amount,
  });

  bool expired;
  int remainingDays;
  int amount;

  factory UserMembership.fromJson(Map<String, dynamic> json) => UserMembership(
    expired: json["expired"],
    remainingDays: json["remaining_days"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "expired": expired,
    "remaining_days": remainingDays,
    "amount": amount,
  };
}

class UserRegistrationTrack {
  UserRegistrationTrack({
    required this.paid,
    required this.amount,
  });

  bool paid;
  int amount;

  factory UserRegistrationTrack.fromJson(Map<String, dynamic> json) => UserRegistrationTrack(
    paid: json["paid"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "paid": paid,
    "amount": amount,
  };
}
class Payments {
  Payments({
    required this.registration,
    required this.membership,
  });

  UserRegistrationTrack registration;
  UserMembership membership;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
    registration: UserRegistrationTrack.fromJson(json["registration"]),
    membership: UserMembership.fromJson(json["membership"]),
  );

  Map<String, dynamic> toJson() => {
    "registration": registration.toJson(),
    "membership": membership.toJson(),
  };
}
class User {
  User({
    required  this.firstName,
    required  this.middleName,
    required  this.lastName,
    required this.id,
    required this.username,
    required this.status,
    required this.gender,
    required  this.title,
    required  this.age,
    required this.picture,
    required  this.email,
    required  this.phone,
    required this.token,
    required this.company,
    required this.payments,
    required this.department,
    required  this.association,
    required  this.role,
  });

  String firstName;
  String id;
  String middleName;
  String lastName;
  String username;
  String status;
  String picture;
  String gender;
  String title;
  int age;
  String email;
  String phone;
  String token;
  Payments payments;
  List<UserDepartment> company;
  List<UserDepartment> department;
  List<UserDepartment> association;
  Role role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    username: json["username"],
    status: json["status"],
    gender: json["gender"],
    picture: json['picture'],
    title: json["title"],
    age: json["age"],
    email: json["email"],
    phone: json["phone"],
    token: json["token"],
    payments: Payments.fromJson(json["payments"]),
    company: json["company"] == [] ? [] : List<UserDepartment>.from(json["company"].map((x) => UserDepartment.fromJson(x))),
    department: json["department"] == [] ? [] : List<UserDepartment>.from(json["department"].map((x) => UserDepartment.fromJson(x))),
    association: json["association"] == [] ? [] :  List<UserDepartment>.from(json["association"].map((x) => UserDepartment.fromJson(x))) ,
    role: Role.fromJson(json["role"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "username": username,
    "status": status,
    "gender": gender,
    "title": title,
    "age": age,
    "email": email,
    "phone": phone,
    "token": token,
    "picture":picture,
    "payments": payments.toJson(),
    "company": List<dynamic>.from(company.map((x) => x.toJson())),
    "department": List<dynamic>.from(department.map((x) => x.toJson())),
    "association": List<dynamic>.from(association.map((x) => x.toJson())),
    "role": role.toJson(),
  };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.status,
    required this.permissions,
  });

  String id;
  String name;
  String status;
  List<Permission> permissions;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    permissions: List<Permission>.from(json["permissions"].map((x) => Permission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
  };
}

class Permission {
  Permission({
  required  this.id,
    required  this.name,
    required  this.value,
  });

  String id;
  String name;
  String value;

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
    id: json["id"],
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "value": value,
  };
}
