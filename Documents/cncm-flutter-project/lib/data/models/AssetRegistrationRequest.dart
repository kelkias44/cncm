// To parse this JSON data, do
//
import 'dart:convert';

AssetRegistrationRequest assetRegistrationRequestFromJson(String str) => AssetRegistrationRequest.fromJson(json.decode(str));

String assetRegistrationRequestToJson(AssetRegistrationRequest data) => json.encode(data.toJson());

class AssetRegistrationRequest {
  AssetRegistrationRequest({
     this.name = "",
     this.type = "",
     this.ownerId = "",
     this.owner = "",
     this.description = "",
     required this.metaData ,
  });

  String name;
  String type;
  String owner;
  String ownerId;
  String description;
  AssetRegisterMetaData metaData;

  factory AssetRegistrationRequest.fromJson(Map<String, dynamic> json) => AssetRegistrationRequest(
    name: json["name"],
    type: json["type"],
    ownerId: json["ownerId"],
    owner: json["owner"],
    description: json["description"],
    metaData: AssetRegisterMetaData.fromJson(json["metaData"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "owner": owner,
    "ownerId": ownerId,
    "description": description,
    "metaData": metaData.toJson(),
  };
}

class AssetRegisterMetaData {
  AssetRegisterMetaData({
     this.author = "",
     this.artist = "",
     this.creator = "",
     this.albumName = "",
     this.title = "",
     this.language = "",
     this.subject = "",
     this.numberOfPages = "",
     this.copyrightStatus = "",
     required this.publisher,
     this.upc = "",
     this.releaseDate = "",
     this.year = "",
     this.trackName = "",
     this.isrc = "",
     this.isecReadable = "",
     required this.contributors,
     this.rated = "",
     this.runtime = "",
     this.genre = "",
     this.director = "",
     this.writer = "",
     this.rossio = "",
     required this.actors,
     this.plot = "",
     this.country = "",
     this.poster = "",
     this.metascore = "",
     this.type = "",
     this.production = "",
     this.website = "",
    required this.exif,
  });

  String author;
  String artist;
  String creator;
  String albumName;
  String title;
  String language;
  String subject;
  String numberOfPages;
  String copyrightStatus;
  Publisher publisher;
  String upc;
  String releaseDate;
  String year;
  String trackName;
  String isrc;
  String isecReadable;
  List<AssetAddContributor> contributors;
  String rated;
  String runtime;
  String genre;
  String director;
  String writer;
  String rossio;
  List<Actor> actors;
  String plot;
  String country;
  String poster;
  String metascore;
  String type;
  String production;
  String website;
  Exif exif;

  factory AssetRegisterMetaData.fromJson(Map<String, dynamic> json) => AssetRegisterMetaData(
    author: json["author"],
    artist: json["artist"],
    creator: json["creator"],
    albumName: json["albumName"],
    title: json["title"],
    language: json["language"],
    subject: json["subject"],
    numberOfPages: json["numberOfPages"],
    copyrightStatus: json["copyrightStatus"],
    publisher: Publisher.fromJson(json["publisher"]),
    upc: json["upc"],
    releaseDate: json["releaseDate"],
    year: json["year"],
    trackName: json["trackName"],
    isrc: json["isrc"],
    isecReadable: json["isecReadable"],
    contributors: List<AssetAddContributor>.from(json["contributors"].map((x) => AssetAddContributor.fromJson(x))),
    rated: json["rated"],
    runtime: json["runtime"],
    genre: json["genre"],
    director: json["director"],
    writer: json["writer"],
    rossio: json["rossio"],
    actors: List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
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
    "artist": artist,
    "creator": creator,
    "albumName": albumName,
    "title": title,
    "language": language,
    "subject": subject,
    "numberOfPages": numberOfPages,
    "copyrightStatus": copyrightStatus,
    "publisher": publisher.toJson(),
    "upc": upc,
    "releaseDate": releaseDate,
    "year": year,
    "trackName": trackName,
    "isrc": isrc,
    "isecReadable": isecReadable,
    "contributors": List<dynamic>.from(contributors.map((x) => x.toJson())),
    "rated": rated,
    "runtime": runtime,
    "genre": genre,
    "director": director,
    "writer": writer,
    "rossio": rossio,
    "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
    "plot": plot,
    "country": country,
    "poster": poster,
    "metascore": metascore,
    "type": type,
    "production": production,
    "website": website,
    "exif": exif.toJson(),
  };
}

class Actor {
  Actor({
     this.name = "",
     this.role  = "",
  });

  String name;
  String role;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    name: json["name"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "role": role,
  };
}

class Publisher {
  Publisher({
     this.id = "",
     this.name = "",
     this.sharePercentage = 0.0,
  });

  String id;
  String name;
  double sharePercentage;


  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
    id: json["id"],
    name: json["name"],
    sharePercentage: json["sharePercentage"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sharePercentage": sharePercentage.toDouble(),

  };
}
class AssetAddContributor {
  AssetAddContributor({
    this.id = "",
    this.name = "",
    this.sharePercentage = 0.0,
    this.role ="",
  });

  String id;
  String name;
  double sharePercentage;
  String role;

  factory AssetAddContributor.fromJson(Map<String, dynamic> json) => AssetAddContributor(
    id: json["id"],
    name: json["name"],
    sharePercentage: json["sharePercentage"],
    role: json["role"] == null ? null : json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sharePercentage": sharePercentage.toDouble(),
    "role": role == null ? null : role,
  };
}

class Exif {
  Exif({
     this.cameraManufacturer = "",
     this.cameraModel = "",
     this.exposureTime  = "",
     this.fNumber = "",
     this.isoSpeedRating = "",
     this.captureDat  = "",
     this.lensFocalLength = "",
    required this.imageSize ,
  });

  String cameraManufacturer;
  String cameraModel;
  String exposureTime;
  String fNumber;
  String isoSpeedRating;
  String captureDat;
  String lensFocalLength;
  ImageSize imageSize;

  factory Exif.fromJson(Map<String, dynamic> json) => Exif(
    cameraManufacturer: json["cameraManufacturer"],
    cameraModel: json["cameraModel"],
    exposureTime: json["exposureTime"],
    fNumber: json["fNumber"],
    isoSpeedRating: json["isoSpeedRating"],
    captureDat: json["captureDat"],
    lensFocalLength: json["lensFocalLength"],
    imageSize: ImageSize.fromJson(json["imageSize"]),
  );

  Map<String, dynamic> toJson() => {
    "cameraManufacturer": cameraManufacturer,
    "cameraModel": cameraModel,
    "exposureTime": exposureTime,
    "fNumber": fNumber,
    "isoSpeedRating": isoSpeedRating,
    "captureDat": captureDat,
    "lensFocalLength": lensFocalLength,
    "imageSize": imageSize.toJson(),
  };
}

class ImageSize {
  ImageSize({
     this.width = "",
     this.height = "",
  });

  String width;
  String height;

  factory ImageSize.fromJson(Map<String, dynamic> json) => ImageSize(
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
  };
}
