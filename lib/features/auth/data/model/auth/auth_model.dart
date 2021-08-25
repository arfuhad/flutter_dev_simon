import 'dart:convert';
import 'package:flutter_dev_simon/features/features.dart';

class AuthModel extends AuthEntity {
  AuthModel({
    required this.data,
  }) : super(data: data);

  final AuthDataModel? data;

  factory AuthModel.fromRawJson(String str) =>
      AuthModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        data:
            json["data"] == null ? null : AuthDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class AuthDataModel extends AuthDataEntity {
  AuthDataModel({
    required this.loginClient,
  }) : super(loginClient: loginClient);

  final LoginClientModel? loginClient;

  factory AuthDataModel.fromRawJson(String str) =>
      AuthDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthDataModel.fromJson(Map<String, dynamic> json) => AuthDataModel(
        loginClient: json["loginClient"] == null
            ? null
            : LoginClientModel.fromJson(json["loginClient"]),
      );

  Map<String, dynamic> toJson() => {
        "loginClient": loginClient == null ? null : loginClient!.toJson(),
      };
}

class LoginClientModel extends LoginClientEntity {
  LoginClientModel({
    required this.message,
    required this.statusCode,
    required this.result,
  }) : super(message: message, statusCode: statusCode, result: result);

  final String message;
  final int statusCode;
  final AuthResultModel? result;

  factory LoginClientModel.fromRawJson(String str) =>
      LoginClientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginClientModel.fromJson(Map<String, dynamic> json) =>
      LoginClientModel(
        message: json["message"] == null ? null : json["message"],
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        result: json["result"] == null
            ? null
            : AuthResultModel.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "statusCode": statusCode == null ? null : statusCode,
        "result": result == null ? null : result!.toJson(),
      };
}

class AuthResultModel extends AuthResultEntity {
  AuthResultModel({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  }) : super(token: token, refreshToken: refreshToken, expiresAt: expiresAt);

  final String token;
  final String refreshToken;
  final DateTime? expiresAt;

  factory AuthResultModel.fromRawJson(String str) =>
      AuthResultModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      AuthResultModel(
        token: json["token"] == null ? null : json["token"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
        expiresAt: json["expiresAt"] == null
            ? null
            : DateTime.parse(json["expiresAt"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "expiresAt": expiresAt == null ? null : expiresAt!.toIso8601String(),
      };
}
