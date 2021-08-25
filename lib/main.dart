import 'package:flutter/material.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:flutter_dev_simon/view/view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initHiveForFlutter();
  Get.put(ServicesController(), permanent: true);
  Get.put(AuthController());
  Get.put(DatasController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.white,
          primaryColor: Colors.white,
          accentColor: COLOR_SUN_FLOWER),
      home: HomeView(
        title: 'FLIGHT',
        subTitle: 'LOCAL',
      ),
      builder: EasyLoading.init(),
    );
  }
}
