import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  AuthEntity({
    required this.data,
  });

  final AuthDataEntity? data;

  @override
  List<Object?> get props => [this.data];
}

class AuthDataEntity extends Equatable {
  AuthDataEntity({
    required this.loginClient,
  });

  final LoginClientEntity? loginClient;

  @override
  List<Object?> get props => [this.loginClient];
}

class LoginClientEntity extends Equatable {
  LoginClientEntity({
    required this.message,
    required this.statusCode,
    required this.result,
  });

  final String message;
  final int statusCode;
  final AuthResultEntity? result;

  @override
  List<Object?> get props => [this.message, this.statusCode, this.result];
}

class AuthResultEntity extends Equatable {
  AuthResultEntity({
    required this.token,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String token;
  final String refreshToken;
  final DateTime? expiresAt;

  @override
  List<Object?> get props => [this.token, this.refreshToken, this.expiresAt];
}
