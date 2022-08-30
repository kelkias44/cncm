// To parse this JSON data, do
//
//     final EarningData = EarningDataFromJson(jsonString);

import 'dart:convert';

EarningData EarningDataFromJson(String str) => EarningData.fromJson(json.decode(str));

String EarningDataToJson(EarningData data) => json.encode(data.toJson());

class EarningData {
    EarningData({
        required this.message,
        required this.error,
        required this.code,
        required this.results,
    });

    String message;
    bool error;
    int code;
    EarningResults results;

    factory EarningData.fromJson(Map<String, dynamic> json) => EarningData(
        message: json["message"],
        error: json["error"],
        code: json["code"],
        results: EarningResults.fromJson(json["results"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "code": code,
        "results": results.toJson(),
    };
}

class EarningResults {
    EarningResults({
        required this.totalAmount,
        required this.status,
    });

    int totalAmount;
    String status;

    factory EarningResults.fromJson(Map<String, dynamic> json) => EarningResults(
        totalAmount: json["totalAmount"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "status": status,
    };
}
