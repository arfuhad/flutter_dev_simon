import 'package:flutter/material.dart';
import 'package:flutter_basic_essentials/flutter_basic_essentials.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/home_view_widgets.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.title, this.subTitle}) : super(key: key);

  final String title;
  final String? subTitle;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AuthController _authController;
  late DatasController _datasController;
  late ScrollController _controller;
  DatasEntity? _datasEntity;

  @override
  void initState() {
    super.initState();
    _controller = new ScrollController()..addListener(_scrollListener);
    _authController = Get.find<AuthController>();
    _datasController = Get.find<DatasController>();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initialDataFetch();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.subTitle == null
              ? Text(widget.title)
              : RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: COLOR_MARINE_BLUE, fontSize: 22)),
                      children: [
                      TextSpan(
                        text: widget.title,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: widget.subTitle!,
                      )
                    ])),
        ),
        body: _datasEntity == null
            ? Container()
            : Container(
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      child: Text(
                        "${_datasEntity!.data!.getPackages!.result!.count} Available Holidays",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: COLOR_MARINE_BLUE)),
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                            itemCount: _datasEntity!
                                .data!.getPackages!.result!.packages!.length,
                            controller: _controller,
                            itemBuilder: (context, index) {
                              final repository = _datasEntity!
                                  .data!.getPackages!.result!.packages!;
                              return cardViewWidget(
                                  imageUrl: repository[index].thumbnail,
                                  bestValue: repository[index].discount == null
                                      ? false
                                      : true,
                                  title: repository[index].title,
                                  description: repository[index].description,
                                  duration: repository[index].durationText,
                                  loyality: repository[index].loyaltyPointText,
                                  amenities: repository[index].amenities!,
                                  price: repository[index].startingPrice);
                            }),
                      ),
                    ),
                  ],
                ),
              ));
  }

  // _scrollListener is for check value of scrolling for fetching data
  Future<void> _scrollListener() async {
    // print(
    // "Controller position: ${_controller.position.extentAfter} | Package Count: ${_datasEntity!.data!.getPackages!.result!.count} | Package Length: ${_datasEntity!.data!.getPackages!.result!.packages!.length}");
    if (_controller.position.pixels == _controller.position.maxScrollExtent &&
        (_datasEntity!.data!.getPackages!.result!.packages!.length <
            _datasEntity!.data!.getPackages!.result!.count)) {
      EasyLoading.show(status: "Loading...");
      GenericValuePasser dataValue = await _datasController.datasExtraCaller(
          skip: _datasEntity!.data!.getPackages!.result!.count -
                      _datasEntity!
                          .data!.getPackages!.result!.packages!.length >=
                  4
              ? 4
              : _datasEntity!.data!.getPackages!.result!.count -
                  _datasEntity!.data!.getPackages!.result!.packages!.length);
      if (dataValue.getBool!) {
        setState(() {
          _datasEntity = dataValue.getObject! as DatasEntity;
          EasyLoading.dismiss();
        });
      }
      print(" calling function");
    }
  }

  // intitalDataFecth used for initial data fetch like authentication and pacakge data fetching
  Future<void> initialDataFetch() async {
    EasyLoading.show(status: "Loading...");
    GenericValuePasser authValue = await _authController.authCaller();
    GenericValuePasser dataValue = await _datasController.datasCaller();
    if (authValue.getBool! && dataValue.getBool!) {
      setState(() {
        _datasEntity = dataValue.getObject! as DatasEntity;
        EasyLoading.dismiss();
      });
    }
  }
}
