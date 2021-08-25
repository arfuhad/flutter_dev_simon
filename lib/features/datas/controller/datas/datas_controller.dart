import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:get/get.dart';

class DatasController extends GetxController {
  late final ServicesController _servicesController;
  late final DatasRemote _datasRemote;
  late final DatasRepository _datasRepository;

  DatasEntity? _datasEntity;

  @override
  void onInit() {
    _servicesController = Get.find<ServicesController>();
    _datasRemote = DatasRemoteImplementation(
        httpLink: _servicesController.getGraphQLHttpLink);
    _datasRepository = DatasRepositoryImplementation(
        datasRemote: _datasRemote,
        networkInfo: _servicesController.getNetworkInfo);
    super.onInit();
  }

  Future<GenericValuePasser> datasCaller() async {
    String message = "";
    bool success = false;

    var result = await _datasRepository.getRemoteDatas(
        auth: Get.find<AuthController>().getAuthEntity!, limit: 4, skip: 0);
    result.fold((l) {
      message = l.message!;
      success = false;
    }, (r) {
      _datasEntity = r;
      message = "Success";
      success = true;
    });
    update();
    return GenericValuePasser(
        valueString: message, valueBool: success, valueObject: _datasEntity);
  }

  Future<GenericValuePasser> datasExtraCaller(
      {required int skip, int limit = 4}) async {
    String message = "";
    bool success = false;

    var result = await _datasRepository.getRemoteDatas(
        auth: Get.find<AuthController>().getAuthEntity!,
        limit: limit,
        skip: skip);
    result.fold((l) {
      message = l.message!;
      success = false;
    }, (r) {
      int length = r.data!.getPackages!.result!.packages!.length;
      if (_datasEntity!.data!.getPackages!.result!.count > length) {
        for (int i = 0; i < length; i++) {
          _datasEntity!.data!.getPackages!.result!.packages!
              .add(r.data!.getPackages!.result!.packages![i]);
        }
      }
      message = "Success";
      success = true;
    });
    update();
    return GenericValuePasser(
        valueString: message, valueBool: success, valueObject: _datasEntity);
  }

  DatasEntity? get getDatasEntity => _datasEntity;

  @override
  void onClose() {
    _datasEntity = null;
    super.onClose();
  }
}
