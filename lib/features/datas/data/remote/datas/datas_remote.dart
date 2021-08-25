import 'dart:developer';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class DatasRemote {
  Future<DatasModel> getDatas(
      {required AuthModel auth, int skip = 0, int limit = 4});
}

class DatasRemoteImplementation implements DatasRemote {
  final HttpLink httpLink;

  DatasRemoteImplementation({required this.httpLink});

  @override
  Future<DatasModel> getDatas(
      {required AuthModel auth, int skip = 0, int limit = 4}) async {
    AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${auth.data!.loginClient!.result!.token}',
    );

    Link link = authLink.concat(httpLink);

    var client = GraphQLClient(link: link, cache: GraphQLCache());
    QueryResult result = await runQurey(
      client: client,
      limit: limit,
      skip: skip,
    );

    List resultPackage = result.data!['getPackages']['result']['packages'];
    List<PackageModel> packageList = [];

    for (int i = 0; i < resultPackage.length; i++) {
      PackageModel package = getPackageModel(resultPackage[i]);
      packageList.add(package);
    }
    return DatasModel(
        data: DataModel(
            getPackages: GetPackagesModel(
      message: result.data!['getPackages']['message'],
      statusCode: result.data!['getPackages']['statusCode'],
      result: ResultModel(
          count: result.data!['getPackages']['result']['count'],
          packages: packageList),
    )));
    // return DatasModel.fromJson(result.data!);
  }

  Future<QueryResult> runQurey(
      {required GraphQLClient client,
      required int skip,
      required int limit}) async {
    final _option =
        QueryOptions(document: gql(QUERY_DATA), variables: <String, dynamic>{
      'skip': skip,
      'limit': limit,
    });

    final result = await client.query(_option);
    return result;
  }

  PackageModel getPackageModel(dynamic value) {
    print("$value");
    List resultamenitites = value['amenities'];
    List<AmenityModel> aminitiyList = [];
    resultamenitites.forEach((e) {
      var aminity = AmenityModel(title: e['title'], icon: e['icon']);
      aminitiyList.add(aminity);
    });
    // print(aminitiyList);
    PackageModel package = PackageModel(
        uid: value['uid'],
        title: value['title'],
        startingPrice: value['startingPrice'],
        thumbnail: value['thumbnail'],
        amenities: aminitiyList,
        discount: value['discount'] == null
            ? null
            : DiscountModel(
                title: value['discount']['title'],
                amount: value['discount']['amount']),
        durationText: value['durationText'],
        loyaltyPointText: value['loyaltyPointText'],
        description: value['description']);
    // print("DATAS REMOTE: GET PACKAGE");
    // print(package.toString());
    return package;
  }
}
