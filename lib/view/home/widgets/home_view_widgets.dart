import 'package:flutter/material.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:flutter_dev_simon/features/features.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cardViewWidget(
    {required String imageUrl,
    required bool bestValue,
    required String title,
    required String description,
    required String duration,
    required String loyality,
    required List<AmenityEntity> amenities,
    required int price}) {
  return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.85,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Column(
          children: [
            Container(
              height: Get.height * 0.225,
              child: Row(
                children: [
                  imageViewerWidget(imageUrl: imageUrl, bestValue: bestValue),
                  infoViewerWidget(
                      title: title,
                      description: description,
                      duration: duration,
                      loyalityPonit: loyality)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                color: COLOR_MARINE_BLUE,
              ),
              height: Get.height * 0.065,
              child: Row(
                children: [
                  amenitiesViewerWidget(amenities: amenities),
                  Spacer(),
                  priceViewingWidget(price: price)
                ],
              ),
            )
          ],
        ),
      ));
}

Widget imageViewerWidget({required String imageUrl, required bool bestValue}) {
  return Container(
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
          ),
          child: Image.network(
            imageUrl,
            width: Get.width * 0.35,
            height: Get.height * 0.225,
            fit: BoxFit.cover,
          ),
        ),
        bestValue
            ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: COLOR_SUN_FLOWER),
                child: Row(children: [
                  Icon(Icons.star, color: COLOR_MARINE_BLUE, size: 11),
                  Text(
                    "Best Value",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: COLOR_MARINE_BLUE,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
              )
            : Container()
      ],
    ),
  );
}

Widget infoViewerWidget({
  required String title,
  required String description,
  required String duration,
  required String loyalityPonit,
}) {
  return Container(
    width: Get.width * 0.6,
    height: Get.height * 0.23,
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: COLOR_MARINE_BLUE,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height * 0.025)),
        ),
        Spacer(),
        Text(
          description,
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(color: COLOR_BLACK, fontSize: Get.height * 0.013)),
        ),
        Spacer(),
        Row(
          children: [
            Image.asset(
              ICON_CALENDER,
              height: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              duration,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: COLOR_MARINE_BLUE, fontSize: Get.height * 0.017)),
            ),
          ],
        ),
        // SizedBox(height: Get.height * 0.005),
        Spacer(),
        Row(
          children: [
            // Icon(Icons.calendar_today,color: COLOR_MARINE_BLUE,),
            Image.asset(
              ICON_FLIGHT,
              height: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              loyalityPonit,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: COLOR_MARINE_BLUE, fontSize: Get.height * 0.017)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget amenitiesViewerWidget({required List<AmenityEntity> amenities}) {
  return Container(
    width: Get.width * 0.55,
    padding: EdgeInsets.only(top: 5, left: 10, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Includes:",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: COLOR_SUN_FLOWER, fontSize: Get.height * 0.015)),
        ),
        Container(
          width: Get.width * 0.55,
          height: Get.height * 0.03,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, ind) {
              return Container(
                width: 15,
                height: 15,
                margin: EdgeInsets.all(3),
                child: SvgPicture.network(amenities[ind].icon,
                    color: COLOR_SUN_FLOWER),
              );
            },
            itemCount: amenities.length,
          ),
        )
      ],
    ),
  );
}

Widget priceViewingWidget({required int price}) {
  return Container(
    padding: EdgeInsets.only(top: 5, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Starts from",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: Get.height * 0.013,
          )),
        ),
        Text(
          "৳ ${price}",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: Get.height * 0.025,
                  fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}
