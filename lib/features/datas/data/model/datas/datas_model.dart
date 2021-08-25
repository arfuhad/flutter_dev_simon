import 'dart:convert';

import 'package:flutter_dev_simon/features/features.dart';

class DatasModel extends DatasEntity {
  DatasModel({
    required this.data,
  }) : super(data: data);

  final DataModel? data;

  factory DatasModel.fromRawJson(String str) =>
      DatasModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatasModel.fromJson(Map<String, dynamic> json) => DatasModel(
        data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class DataModel extends DataEntity {
  DataModel({
    required this.getPackages,
  }) : super(getPackages: getPackages);

  final GetPackagesModel? getPackages;

  factory DataModel.fromRawJson(String str) =>
      DataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        getPackages: json["getPackages"] == null
            ? null
            : GetPackagesModel.fromJson(json["getPackages"]),
      );

  Map<String, dynamic> toJson() => {
        "getPackages": getPackages == null ? null : getPackages!.toJson(),
      };
}

class GetPackagesModel extends GetPackagesEntity {
  GetPackagesModel({
    required this.statusCode,
    required this.message,
    required this.result,
  }) : super(statusCode: statusCode, message: message, result: result);

  final int statusCode;
  final String message;
  final ResultModel? result;

  factory GetPackagesModel.fromRawJson(String str) =>
      GetPackagesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPackagesModel.fromJson(Map<String, dynamic> json) =>
      GetPackagesModel(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null
            ? null
            : ResultModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "result": result == null ? null : result!.toJson(),
      };
}

class ResultModel extends ResultEntity {
  ResultModel({
    required this.count,
    required this.packages,
  }) : super(count: count, packages: packages);

  final int count;
  final List<PackageModel>? packages;

  factory ResultModel.fromRawJson(String str) =>
      ResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        count: json["count"] == null ? null : json["count"],
        packages: json["packages"] == null
            ? null
            : List<PackageModel>.from(
                json["packages"].map((x) => PackageModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
        "packages": packages == null
            ? null
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
      };
}

class PackageModel extends PackageEntity {
  PackageModel({
    required this.uid,
    required this.title,
    required this.startingPrice,
    required this.thumbnail,
    required this.amenities,
    required this.discount,
    required this.durationText,
    required this.loyaltyPointText,
    required this.description,
  }) : super(
            uid: uid,
            title: title,
            startingPrice: startingPrice,
            thumbnail: thumbnail,
            amenities: amenities,
            discount: discount,
            durationText: durationText,
            loyaltyPointText: loyaltyPointText,
            description: description);

  final String uid;
  final String title;
  final int startingPrice;
  final String thumbnail;
  final List<AmenityModel>? amenities;
  final DiscountModel? discount;
  final String durationText;
  final String loyaltyPointText;
  final String description;

  factory PackageModel.fromRawJson(String str) =>
      PackageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        uid: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        startingPrice:
            json["startingPrice"] == null ? null : json["startingPrice"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        amenities: json["amenities"] == null
            ? null
            : List<AmenityModel>.from(
                json["amenities"].map((x) => AmenityModel.fromJson(x))),
        discount: json["discount"] == null
            ? null
            : DiscountModel.fromJson(json["discount"]),
        durationText:
            json["durationText"] == null ? null : json["durationText"],
        loyaltyPointText:
            json["loyaltyPointText"] == null ? null : json["loyaltyPointText"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "title": title == null ? null : title,
        "startingPrice": startingPrice == null ? null : startingPrice,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "amenities": amenities == null
            ? null
            : List<AmenityModel>.from(amenities!.map((x) => x.toJson())),
        "discount": discount == null ? null : discount,
        "durationText": durationText == null ? null : durationText,
        "loyaltyPointText": loyaltyPointText == null ? null : loyaltyPointText,
        "description": description == null ? null : description,
      };
}

class AmenityModel extends AmenityEntity {
  AmenityModel({
    required this.title,
    required this.icon,
  }) : super(title: title, icon: icon);

  final String title;
  final String icon;

  factory AmenityModel.fromRawJson(String str) =>
      AmenityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AmenityModel.fromJson(Map<String, dynamic> json) => AmenityModel(
        title: json["title"] == null ? null : json["title"],
        icon: json["icon"] == null ? null : json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "icon": icon == null ? null : icon,
      };
}

class DiscountModel extends DiscountEntity {
  DiscountModel({
    required this.title,
    required this.amount,
  }) : super(title: title, amount: amount);

  final String title;
  final int amount;

  factory DiscountModel.fromRawJson(String str) =>
      DiscountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
        title: json["title"] == null ? null : json["title"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "amount": amount == null ? null : amount,
      };
}
