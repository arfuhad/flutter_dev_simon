import 'package:dartz/dartz.dart';
import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/features/features.dart';

abstract class DatasRepository {
  Future<Either<GenericFailure, DatasEntity>> getRemoteDatas(
      {required AuthEntity auth, int skip = 0, int limit = 4});
}

class DatasRepositoryImplementation implements DatasRepository {
  final DatasRemote datasRemote;
  final NetworkInfo networkInfo;

  DatasRepositoryImplementation(
      {required this.datasRemote, required this.networkInfo});

  @override
  Future<Either<GenericFailure, DatasEntity>> getRemoteDatas(
      {required AuthEntity auth, int skip = 0, int limit = 4}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await datasRemote.getDatas(
            auth: AuthModel(
                data: AuthDataModel(
                    loginClient: LoginClientModel(
                        message: auth.data!.loginClient!.message,
                        statusCode: auth.data!.loginClient!.statusCode,
                        result: AuthResultModel(
                            token: auth.data!.loginClient!.result!.token,
                            refreshToken:
                                auth.data!.loginClient!.result!.refreshToken,
                            expiresAt:
                                auth.data!.loginClient!.result!.expiresAt)))),
            limit: limit,
            skip: skip);
        if (result.data!.getPackages!.message == "SUCCESS") {
          return Right(result);
        } else {
          return Left(AuthenticationFailure(result.data!.getPackages!.message));
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
