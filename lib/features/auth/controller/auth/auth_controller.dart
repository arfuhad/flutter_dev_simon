import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late final ServicesController _servicesController;
  late final AuthLocal _authLocal;
  late final AuthRemote _authRemote;
  late final AuthRepository _authRepository;

  AuthEntity? _authEntity;

  @override
  Future<void> onInit() async {
    _servicesController = Get.find<ServicesController>();
    _authLocal = AuthLocalImplementation();
    _authRemote = AuthRemoteImplementation(
        httpLink: _servicesController.getGraphQLHttpLink);
    _authRepository = AuthRepositoryImplementation(
        authLocal: _authLocal,
        authRemote: _authRemote,
        networkInfo: _servicesController.getNetworkInfo);
    super.onInit();
  }

  Future<GenericValuePasser> authCaller() async {
    String message = "";
    bool success = false;

    var result = await _authRepository.getRemoteAuthentication();
    result.fold((l) {
      message = l.message!;
      success = false;
    }, (r) {
      _authEntity = r;
      message = "Success";
      success = true;
    });
    update();
    return GenericValuePasser(
        valueString: message, valueBool: success, valueObject: _authEntity);
  }

  Future<GenericValuePasser> authGetter() async {
    String message = "";
    bool success = false;

    var result = _authRepository.getLocalAuthentication();
    result.fold((l) {
      message = l.message!;
      success = false;
    }, (r) {
      _authEntity = r;
      message = "Success";
      success = true;
    });
    update();
    return GenericValuePasser(
        valueString: message, valueBool: success, valueObject: _authEntity);
  }

  Future<GenericValuePasser> authDelete() async {
    String message = "";
    bool success = false;

    var result = await _authRepository.deleteAuthentication();
    result.fold((l) {
      message = l.message!;
      success = false;
    }, (r) {
      _authEntity = null;
      message = "Success";
      success = true;
    });
    update();
    return GenericValuePasser(valueString: message, valueBool: success);
  }

  AuthEntity? get getAuthEntity => _authEntity;

  @override
  void onClose() {
    _authEntity = null;
    super.onClose();
  }
}
