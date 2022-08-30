// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
    NotificationResponse({
      required this.message,
      required this.error,
      required this.code,
      required this.results,
    });

    String message;
    bool error;
    int code;
    Results results;

    factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        message: json["message"],
        error: json["error"],
        code: json["code"],
        results: Results.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "code": code,
        "results": results.toJson(),
    };
}

class Results {
    Results({
      required this.count,
      required this.rows,
    });

    int count;
    Rows rows;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        count: json["count"],
        rows: Rows.fromJson(json["rows"]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "rows": rows.toJson(),
    };
}

class Rows {
    Rows({
      required   this.id,
       required  this.username,
       required  this.notifications,
    });

    String id;
    String username;
    List<Notification> notifications;

    factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        id: json["id"],
        username: json["username"],
        notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
    };
}

class Notification {
    Notification({
        required this.id,
      required   this.title,
       required  this.status,
       required  this.body,
       required  this.time,
      required   this.priority,
       required  this.seen,
    });

    String id;
    String title;
    String status;
    Body body;
    DateTime time;
    String priority;
    bool seen;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        body: Body.fromJson(json["body"]),
        time: DateTime.parse(json["time"]),
        priority: json["priority"],
        seen: json["seen"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "body": body.toJson(),
        "time": time.toIso8601String(),
        "priority": priority,
        "seen": seen,
    };
}

class Body {
    Body({
        required this.group,
        required this.message,
    });

    Group group;
    String message;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        group: Group.fromJson(json["group"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "group": group.toJson(),
        "message": message,
    };
}

class Group {
    Group({
        required this.id,
        required this.name,
        required this.type,
    });

    String id;
    String name;
    String type;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
    };
}
