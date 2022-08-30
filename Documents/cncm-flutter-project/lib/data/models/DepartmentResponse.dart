
import 'dart:convert';

DepartmentResponse departmentResponseFromJson(String str) => DepartmentResponse.fromJson(json.decode(str));

String departmentResponseToJson(DepartmentResponse data) => json.encode(data.toJson());

class DepartmentResponse {
  DepartmentResponse({
   required this.message,
    required this.error,
    required this.code,
    required this.results,
  });

  String message;
  bool error;
  int code;
  DepartmentData results;

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) => DepartmentResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: DepartmentData.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results.toJson(),
  };
}

class DepartmentData {
  DepartmentData({
    required  this.count,
    required  this.departments,
  });

  int count;
  List<Department> departments;

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
    count: json["count"],
    departments: List<Department>.from(json["rows"].map((x) => Department.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": List<dynamic>.from(departments.map((x) => x.toJson())),
  };
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
  });

  String id;
  String name;
  String description;
  String type;
  String status;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "type": type,
    "status": status,
  };
}
