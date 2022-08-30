// To parse this JSON data, do
//
//     final unreadNotificationResponse = unreadNotificationResponseFromJson(jsonString);

import 'dart:convert';

UnreadNotificationResponse unreadNotificationResponseFromJson(String str) => UnreadNotificationResponse.fromJson(json.decode(str));

String unreadNotificationResponseToJson(UnreadNotificationResponse data) => json.encode(data.toJson());

class UnreadNotificationResponse {
    UnreadNotificationResponse({
       required this.message,
       required this.error,
       required this.code,
       required this.results,
    });

    String message;
    bool error;
    int code;
    Results results;

    factory UnreadNotificationResponse.fromJson(Map<String, dynamic> json) => UnreadNotificationResponse(
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
      required  this.read,
       required this.unread,
    });

    String read;
    int unread;

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        read: json["read"],
        unread: json["unread"] == 0 ?  json["unread"] : int.parse(json["unread"]),
    );

    Map<String, dynamic> toJson() => {
        "read": read,
        "unread": unread,
    };
}
