import 'dart:developer';

import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class AuthRemote {
  Future<AuthModel> getAuth();
}

class AuthRemoteImplementation implements AuthRemote {
  final HttpLink httpLink;
  late GraphQLClient client;

  AuthRemoteImplementation({required this.httpLink}) {
    client = GraphQLClient(link: this.httpLink, cache: GraphQLCache());
  }

  @override
  Future<AuthModel> getAuth() async {
    QueryResult result = await runMutation();
    return AuthModel(
        data: AuthDataModel(
            loginClient: LoginClientModel(
                message: result.data!['loginClient']['message'],
                statusCode: result.data!['loginClient']['statusCode'],
                result: AuthResultModel(
                    token: result.data!['loginClient']['result']['token'],
                    refreshToken: result.data!['loginClient']['result']
                        ['refreshToken'],
                    expiresAt: DateTime.parse(
                        result.data!['loginClient']['result']['expiresAt'])))));
  }

  Future<QueryResult> runMutation() async {
    final _option = MutationOptions(
      document: gql(QUREY_AUTH),
    );

    final result = await client.mutate(_option);
    return result;
  }
}
