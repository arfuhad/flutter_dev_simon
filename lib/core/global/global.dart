import 'dart:ui';

const URL = "https://b2c-api.flightlocal.com/graphql";

const CACHED_AUTH = 'CACHED_AUTH_TOKEN';

const QUERY_DATA = r"""
            query getPackagesData($skip: Int!, $limit: Int!){
              getPackages(pagination: {skip: $skip, limit: $limit}) {
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

const QUREY_AUTH = """
            mutation {
              loginClient(
                auth: {
                  email: "devteam@saimonglobal.com", 
                  deviceUuid: "7026a238-d078-48b5-862b-c3c7d21d8712"}, 
                password: "12345678") {
                  message
                  statusCode
                  result {
                    token
                    refreshToken
                    expiresAt
                  }
                }
            }
            """;

const COLOR_MARINE_BLUE = Color(0xFF00276C);
const COLOR_SUN_FLOWER = Color(0xFFFFC610);
const COLOR_BLACK = Color(0xFF222222);

const ICON_FLIGHT = 'assets/icons/flight_icon.png';
const ICON_CALENDER = 'assets/icons/calender_icon.png';
