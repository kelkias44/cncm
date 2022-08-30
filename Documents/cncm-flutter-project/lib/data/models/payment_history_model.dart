import 'dart:convert';

PaymentHistoryModel paymentHistoryModelFromJson(String str) => PaymentHistoryModel.fromJson(json.decode(str));

String paymentHistoryModelToJson(PaymentHistoryModel data) => json.encode(data.toJson());

class PaymentHistoryModel {
    PaymentHistoryModel({
        required this.message,
        required this.error,
        required this.code,
        required this.results,
    });

    String message;
    bool error;
    int code;
    Results results;

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
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
        required this.id,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.payments,
    });

    String id;
    String firstName;
    String middleName;
    String lastName;
    List<Payment> payments;

    factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
    };
}

class Payment {
    Payment({
        required this.id,
        required this.type,
        required this.amount,
        required this.trnxName,
        required this.status,
        required this.reasonFailed,
        required this.createdAt,
    });

    String id;
    String type;
    int amount;
    String trnxName;
    String status;
    String reasonFailed;
    DateTime createdAt;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        trnxName: json["trnxName"],
        status: json["status"],
        reasonFailed: json["reasonFailed"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "trnxName": trnxName,
        "status": status,
        "reasonFailed": reasonFailed,
        "createdAt": createdAt.toIso8601String(),
    };
}
