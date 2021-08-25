import 'dart:convert';
import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocal {
  ///this function for cacheing the auth token for future use in the device
  ///cacheAuth({@required AuthModel auth}) return Future [bool]
  Future<void> setLocalAuthentication({required AuthModel auth});

  ///this function for getting the cached data of AuthModel for use in app
  ///getAuth() returns Future [AuthEntity] / [CacheException]
  AuthEntity getLocalAuthentication();

  ///this function for deleting the cached data of AuthModel in app
  ///deleteAuth() returns Future [bool]
  Future<bool> deleteLocalAuthentication();
}

class AuthLocalImplementation implements AuthLocal {
  // final SharedPreferences sharedPreferences;

  // AuthLocalImplementation({required this.sharedPreferences});
  AuthLocalImplementation();

  @override
  Future<bool> deleteLocalAuthentication() async {
    // return await sharedPreferences.clear();
    return await Get.find<SharedPreferences>().clear();
  }

  @override
  AuthEntity getLocalAuthentication() {
    final token = Get.find<SharedPreferences>().getString(CACHED_AUTH);
    if (token != null) {
      return AuthModel.fromJson(json.decode(token));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setLocalAuthentication({required AuthModel auth}) async {
    Get.putAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(CACHED_AUTH, json.encode(auth.toJson()));
      return prefs;
    });
  }
}
