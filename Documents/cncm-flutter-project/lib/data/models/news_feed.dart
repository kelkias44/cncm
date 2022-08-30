
class NewsFeedResponse {
  NewsFeedResponse({
    required  this.message,
    required  this.error,
    required  this.code,
    required  this.results,
  });

  String message;
  bool error;
  int code;
  Results results;

  factory NewsFeedResponse.fromJson(Map<String, dynamic> json) => NewsFeedResponse(
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
  required  this.count,
    required  this.newsFeed,
  });

  int count;
  List<NewsFeed> newsFeed;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    count: json["count"],
    newsFeed: json["count"] == [] ? [] : List<NewsFeed>.from(json["rows"].map((x) => NewsFeed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": List<dynamic>.from(newsFeed.map((x) => x.toJson())),
  };
}
class NewsFeed {
  NewsFeed({
   required this.id,
    required this.title,
    required this.type,
    required this.thumbnail,
    required this.status,
    required this.body,
    required this.time,
  });

  String id;
  String title;
  String type;
  String thumbnail;
  String status;
  Body? body;
  DateTime time;

  factory NewsFeed.fromJson(Map<String, dynamic> json) => NewsFeed(
    id: json["id"],
    title: json["title"],
    type: json["type"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    body:json["body"] == null ? null :  Body.fromJson(json["body"]),
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "type": type,
    "thumbnail": thumbnail,
    "status": status,
    "body": body?.toJson(),
    "time": time.toIso8601String(),
  };
}

class Body {
  Body({
   required this.link,
    required this.duration,
    required  this.title,
    required this.ownerName,
    required this.description,
    required this.subtitle,
  });

  String link;
  String duration;
  String title;
  String ownerName;
  String description;
  String subtitle;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    link: json["link"],
    duration: json["duration"],
    title: json["title"],
    ownerName: json["ownerName"],
    description: json["description"],
    subtitle: json["subtitle"] == null ? "" : json["subtitle"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "duration": duration,
    "title": title,
    "ownerName": ownerName,
    "description": description,
    "subtitle": subtitle == null ? "" : subtitle,
  };
}

