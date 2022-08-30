// To parse this JSON data, do
//
//     final assetResponse = assetResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AssetResponse assetResponseFromJson(String str) => AssetResponse.fromJson(json.decode(str));

String assetResponseToJson(AssetResponse data) => json.encode(data.toJson());

class AssetResponse {
  AssetResponse({
     this.message,
     this.error,
     this.code,
     this.results,
  });

  String? message;
  bool? error;
  int? code;
  AssetResponseResults? results;

  factory AssetResponse.fromJson(Map<String, dynamic> json) => AssetResponse(
    message: json["message"],
    error: json["error"],
    code: json["code"],
    results: AssetResponseResults.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "code": code,
    "results": results!.toJson(),
  };
}

class AssetResponseResults {
  AssetResponseResults({
     this.count,
     this.assetData,
  });

  int? count;
  AssetData? assetData;

  factory AssetResponseResults.fromJson(Map<String, dynamic> json) => AssetResponseResults(
    count: json["count"],
    assetData: AssetData.fromJson(json["rows"]),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "rows": assetData!.toJson(),
  };
}

class AssetData {
  AssetData({
     this.id,
     this.firstName,
     this.middleName,
     this.lastName,
     this.status,
     this.username,
     this.prefixCode,
     this.assets,
  });

  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? status;
  String? username;
  dynamic prefixCode;
  List<Asset>? assets;

  factory AssetData.fromJson(Map<String, dynamic> json) => AssetData(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    status: json["status"],
    username: json["username"],
    prefixCode: json["prefix_code"]  ,
    assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "status": status,
    "username": username,
    "prefix_code": prefixCode,
    "assets": List<dynamic>.from(assets!.map((x) => x.toJson())),
  };
}

class Asset {
  Asset({
     this.id,
     this.name,
    this.description,
     this.status,
     this.assetMetaData,
     this.department,
  });

  String? id;
  String? name;
  String? description;
  String? status;
  AssetMetaData? assetMetaData;
  AssetDepartment? department;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    name: json["name"],
    description: json["description"] ==null?"No descripition":json["description"].toString(),
    status: json["status"],
    assetMetaData: AssetMetaData.fromJson(json["metaData"]),
    department: AssetDepartment.fromJson(json["department"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
    "metaData": assetMetaData!.toJson(),
    "department": department!.toJson(),
  };
}

class AssetDepartment {
  AssetDepartment({
     this.id,
     this.name,
     this.type,
  });

  String? id;
  String? name;
  String? type;

  factory AssetDepartment.fromJson(Map<String, dynamic> json) => AssetDepartment(
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

class AssetMetaData {
  AssetMetaData({
     this.author,
     this.title,
     this.language,
     this.subject,
    this.description,
     this.numberOfPages,
     this.copyrightStatus,
     this.publisher,
     this.upc,
     this.releaseDate,
     this.year,
     this.trackName,
     this.isrc,
     this.isecReadable,
     this.contributors,
     this.rated,
     this.runtime,
     this.genre,
     this.director,
     this.writer,
     this.rossio,
     this.actors,
     this.plot,
     this.country,
     this.poster,
     this.metascore,
     this.type,
     this.production,
     this.website,
     this.exif,
  });

  String? author;
  String? title;
  String? language;
  String? subject;
  String? description;
  String? numberOfPages;
  String? copyrightStatus;
  PublisherClass? publisher;
  String? upc;
  String? releaseDate;
  String? year;
  String? trackName;
  String? isrc;
  String? isecReadable;
  List<Contributor>? contributors;
  String? rated;
  String? runtime;
  String? genre;
  String? director;
  String? writer;
  String? rossio;
  List<Actor>? actors;
  String? plot;
  String? country;
  String? poster;
  String? metascore;
  String? type;
  String? production;
  String? website;
  Exif? exif;

  factory AssetMetaData.fromJson(Map<String, dynamic> json) => AssetMetaData(
    author: json["author"],
    title: json["title"],
    language: json["language"],
    subject: json["subject"],
    description: json["Description"],
    numberOfPages: json["numberOfPages"],
    copyrightStatus: json["copyrightStatus"],
    publisher: PublisherClass.fromJson(json["publisher"]),
    upc: json["upc"],
    releaseDate: json["releaseDate"],
    year: json["year"],
    trackName: json["trackName"],
    isrc: json["isrc"],
    isecReadable: json["isecReadable"],
    contributors: List<Contributor>.from(json["contributors"].map((x) => Contributor.fromJson(x))),
    rated: json["rated"],
    runtime: json["runtime"],
    genre: json["genre"],
    director: json["director"],
    writer: json["writer"],
    rossio: json["rossio"],
    actors: json["actors"] == [] ? [] : List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
    plot: json["plot"],
    country: json["country"],
    poster: json["poster"],
    metascore: json["metascore"],
    type: json["type"],
    production: json["production"],
    website: json["website"],
    exif: Exif.fromJson(json["exif"]),
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "title": title,
    "language": language,
    "subject": subject,
    "Description": description,
    "numberOfPages": numberOfPages,
    "copyrightStatus": copyrightStatus,
    "publisher": publisher,
    "upc": upc,
    "releaseDate": releaseDate,
    "year": year,
    "trackName": trackName,
    "isrc": isrc,
    "isecReadable": isecReadable,
    "contributors": List<dynamic>.from(contributors!.map((x) => x.toJson())),
    "rated": rated,
    "runtime": runtime,
    "genre": genre,
    "director": director,
    "writer": writer,
    "rossio": rossio,
    "actors": List<dynamic>.from(actors!.map((x) => x.toJson())),
    "plot": plot,
    "country": country,
    "poster": poster,
    "metascore": metascore,
    "type": type,
    "production": production,
    "website": website,
    "exif": exif!.toJson(),
  };
}

class Actor {
  Actor({
     this.name,
     this.role,
  });

  String? name;
  String? role;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "role": role,
  };
}

class Contributor {
  Contributor({
     this.fullName,
     this.approved,
     this.id,
     this.name,
     this.role,
     this.sharePercentage,
     this.status,
  });

  String? fullName;
  bool? approved;
  String? id;
  String? name;
  String? role;
  dynamic sharePercentage;
  String? status;

  factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
    fullName: json["fullName"],
    approved: json["approved"],
    id: json["id"],
    name: json["name"] ?? "",
    role: json["role"],
    sharePercentage: json["sharePercentage"].toString(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "approved": approved,
    "id": id,
    "name": name == null ? "" : name,
    "role": role,
    "sharePercentage": sharePercentage,
    "status": status,
  };
}

class Exif {
  Exif({
     this.isoSpeedRating,
     this.cameraManufacturer,
     this.cameraModel,
     this.captureDat,
     this.exposureTime,
     this.fNumber,
     this.imageSize,
     this.lensFocalLength,
  });

  String? isoSpeedRating;
  String? cameraManufacturer;
  String? cameraModel;
  String? captureDat;
  String? exposureTime;
  String? fNumber;
  ImageSize? imageSize;
  String? lensFocalLength;

  factory Exif.fromJson(Map<String, dynamic> json) => Exif(
    isoSpeedRating: json["isoSpeedRating"],
    cameraManufacturer: json["cameraManufacturer"],
    cameraModel: json["cameraModel"],
    captureDat: json["captureDat"],
    exposureTime: json["exposureTime"],
    fNumber: json["fNumber"],
    imageSize: ImageSize.fromJson(json["imageSize"]),
    lensFocalLength: json["lensFocalLength"],
  );

  Map<String, dynamic> toJson() => {
    "isoSpeedRating": isoSpeedRating,
    "cameraManufacturer": cameraManufacturer,
    "cameraModel": cameraModel,
    "captureDat": captureDat,
    "exposureTime": exposureTime,
    "fNumber": fNumber,
    "imageSize": imageSize!.toJson(),
    "lensFocalLength": lensFocalLength,
  };
}

class ImageSize {
  ImageSize({
     this.imageSizeHeight,
     this.width,
     this.height,
  });

  String? imageSizeHeight;
  String? width;
  String? height;

  factory ImageSize.fromJson(Map<String, dynamic> json) => ImageSize(
    imageSizeHeight: json["height"] ?? "",
    width: json["width"] ?? "",
    height: json["Height"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "height": imageSizeHeight,
    "width": width ,
    "Height": height ,
  };
}

class PublisherClass {
  PublisherClass({
     this.id,
     this.name,
      this.sharePercentage,
  });

  String? id;
  String? name;
  String? sharePercentage;

  factory PublisherClass.fromJson(Map<String, dynamic> json) => PublisherClass(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    sharePercentage: json["sharePercentage"].toString() ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sharePercentage": sharePercentage,
  };
}






