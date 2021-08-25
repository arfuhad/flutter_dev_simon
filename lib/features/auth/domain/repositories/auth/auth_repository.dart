import 'package:dartz/dartz.dart';
import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/features/auth/data/remote/auth/auth_remote.dart';
import 'package:flutter_dev_simon/features/features.dart';

abstract class AuthRepository {
  Future<Either<GenericFailure, AuthEntity>> getRemoteAuthentication();
  Either<GenericFailure, AuthEntity> getLocalAuthentication();
  Future<Either<GenericFailure, bool>> setAuthentication(AuthEntity? auth);
  Future<Either<GenericFailure, bool>> deleteAuthentication();
}

class AuthRepositoryImplementation implements AuthRepository {
  final AuthLocal authLocal;
  final AuthRemote authRemote;
  final NetworkInfo networkInfo;

  AuthRepositoryImplementation(
      {required this.authLocal,
      required this.authRemote,
      required this.networkInfo});

  @override
  Future<Either<GenericFailure, bool>> deleteAuthentication() async {
    try {
      final result = await authLocal.deleteLocalAuthentication();
      if (result) {
        return Right(result);
      } else {
        return Left(CacheFailure());
      }
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<GenericFailure, AuthEntity> getLocalAuthentication() {
    try {
      final result = authLocal.getLocalAuthentication();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<GenericFailure, AuthEntity>> getRemoteAuthentication() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await authRemote.getAuth();
        if (result.data!.loginClient!.message == "SUCCESS") {
          await authLocal.setLocalAuthentication(auth: result);
          return Right(result);
        } else {
          return Left(AuthenticationFailure(result.data!.loginClient!.message));
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<GenericFailure, bool>> setAuthentication(
      AuthEntity? auth) async {
    try {
      await authLocal.setLocalAuthentication(
          auth: AuthModel(
              data: AuthDataModel(
                  loginClient: LoginClientModel(
                      message: auth!.data!.loginClient!.message,
                      statusCode: auth.data!.loginClient!.statusCode,
                      result: AuthResultModel(
                          token: auth.data!.loginClient!.result!.token,
                          refreshToken:
                              auth.data!.loginClient!.result!.refreshToken,
                          expiresAt:
                              auth.data!.loginClient!.result!.expiresAt)))));
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
