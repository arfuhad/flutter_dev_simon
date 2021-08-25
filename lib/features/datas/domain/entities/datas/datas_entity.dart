import 'package:equatable/equatable.dart';

class DatasEntity extends Equatable {
  DatasEntity({
    required this.data,
  });

  final DataEntity? data;

  @override
  List<Object?> get props => [this.data];
}

class DataEntity extends Equatable {
  DataEntity({
    required this.getPackages,
  });

  final GetPackagesEntity? getPackages;

  @override
  List<Object?> get props => [this.getPackages];
}

class GetPackagesEntity extends Equatable {
  GetPackagesEntity({
    required this.statusCode,
    required this.message,
    required this.result,
  });

  final int statusCode;
  final String message;
  final ResultEntity? result;

  @override
  List<Object?> get props => [this.statusCode, this.message, this.result];
}

class ResultEntity extends Equatable {
  ResultEntity({
    required this.count,
    required this.packages,
  });

  final int count;
  final List<PackageEntity>? packages;

  @override
  List<Object?> get props => [this.count, this.packages];
}

class PackageEntity extends Equatable {
  PackageEntity({
    required this.uid,
    required this.title,
    required this.startingPrice,
    required this.thumbnail,
    required this.amenities,
    required this.discount,
    required this.durationText,
    required this.loyaltyPointText,
    required this.description,
  });

  final String uid;
  final String title;
  final int startingPrice;
  final String thumbnail;
  final List<AmenityEntity>? amenities;
  final DiscountEntity? discount;
  final String durationText;
  final String loyaltyPointText;
  final String description;

  @override
  List<Object?> get props => [
        this.uid,
        this.title,
        this.startingPrice,
        this.thumbnail,
        this.amenities,
        this.discount,
        this.durationText,
        this.loyaltyPointText,
        this.description
      ];
}

class AmenityEntity extends Equatable {
  AmenityEntity({
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  List<Object?> get props => [this.title, this.icon];
}

class DiscountEntity extends Equatable {
  DiscountEntity({
    required this.title,
    required this.amount,
  });

  final String title;
  final int amount;

  @override
  List<Object?> get props => [this.title, this.amount];
}
