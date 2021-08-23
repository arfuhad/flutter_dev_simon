import 'dart:ui';

import 'package:graphql_flutter/graphql_flutter.dart';

const URL = "https://b2c-api.flightlocal.com/graphql";

const QUERY = """
            query{
              getPackages(pagination: {\$skip: Int!, \$limit: Int!}) {
                statusCode
                message
                result {
                  count
                  packages {
                    uid
                    title
                    startingPrice
                    thumbnail
                    amenities {
                      title
                      icon
                    }
                    discount {
                      title
                      amount
                    }
                    durationText
                    loyaltyPointText
                    description
                  }
                }
              }
            }
            """;

const COLOR_MARINE_BLUE = Color(0xFF00276C);
const COLOR_SUN_FLOWER = Color(0xFFFFC610);
const COLOR_BLACK = Color(0xFF222222);

const ICON_FLIGHT = 'assets/icons/flight_icon.png';
const ICON_CALENDER = 'assets/icons/calender_icon.png';
