import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SERVICE_TAG = "Setup Locator:";

class ServicesController extends GetxController {
  late DataConnectionChecker _dataConnectionChecker;
  late NetworkInfo _networkInfo;
  late HttpLink _httpLink;

  @override
  Future<void> onInit() async {
    _dataConnectionChecker = DataConnectionChecker();
    _networkInfo = NetworkInfoImpl(_dataConnectionChecker);
    _httpLink = HttpLink(URL);
    super.onInit();
  }

  NetworkInfo get getNetworkInfo => _networkInfo;
  HttpLink get getGraphQLHttpLink => _httpLink;
}
