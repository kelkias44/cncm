// To parse this JSON data, do
//
//     final bulkAssetRegistrationRequest = bulkAssetRegistrationRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'AssetRegistrationRequest.dart';



class BulkAssetRegistrationRequest {
  BulkAssetRegistrationRequest({
    required this.assets,
  });

  List<AssetRegistrationRequest> assets;

  factory BulkAssetRegistrationRequest.fromJson(Map<String, dynamic> json) => BulkAssetRegistrationRequest(
    assets: List<AssetRegistrationRequest>.from(json["assets"].map((x) => AssetRegistrationRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
  };
}

// class Asset {
//   Asset({
//     required this.name,
//     required this.metaData,
//     required this.type,
//     required this.owner,
//     required this.ownerId,
//   });
//
//   String name;
//   MetaData metaData;
//   String type;
//   String owner;
//   String ownerId;
//
//   factory Asset.fromJson(Map<String, dynamic> json) => Asset(
//     name: json["name"],
//     metaData: MetaData.fromJson(json["metaData"]),
//     type: json["type"],
//     owner: json["owner"],
//     ownerId: json["ownerId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "metaData": metaData.toJson(),
//     "type": type,
//     "owner": owner,
//     "ownerId": ownerId,
//   };
// }
//
// class MetaData {
//   MetaData({
//     required this.contributors,
//     required this.publisher,
//     required this.publisherPercentage,
//   });
//
//   List<Contributor> contributors;
//   String publisher;
//   String publisherPercentage;
//
//   factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
//     contributors: List<Contributor>.from(json["contributors"].map((x) => Contributor.fromJson(x))),
//     publisher: json["publisher"],
//     publisherPercentage: json["publisherPercentage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "contributors": List<dynamic>.from(contributors.map((x) => x.toJson())),
//     "publisher": publisher,
//     "publisherPercentage": publisherPercentage,
//   };
// }
//
// class Contributor {
//   Contributor({
//     required this.id,
//     required this.role,
//     required this.sharePercentage,
//   });
//
//   String id;
//   String role;
//   int sharePercentage;
//
//   factory Contributor.fromJson(Map<String, dynamic> json) => Contributor(
//     id: json["id"],
//     role: json["role"],
//     sharePercentage: json["sharePercentage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "role": role,
//     "sharePercentage": sharePercentage,
//   };
// }
