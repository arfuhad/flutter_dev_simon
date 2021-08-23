import 'package:flutter/material.dart';
import 'package:flutter_dev_simon/core/core.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final HttpLink httpLink = HttpLink("https://countries.trevorblades.com/");
    final HttpLink httpLink =
        HttpLink("https://b2c-api.flightlocal.com/graphql");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())));
    return GraphQLProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Test GraphQL'),
      ),
      client: client,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Query(
          options: QueryOptions(document: gql("""
            query{
              getPackages(pagination: {skip: 0, limit: 10}) {
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
            """)),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Text('Loading');
            }

            // print(result.data!['getPackages']['result']['packages']);
            // it can be either Map or List
            List repositories =
                result.data!['getPackages']['result']['packages'];

            return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repository = repositories[index];

                  print(repository['amenities'].runtimeType);

                  // return Text(repository['name']);
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Row(
                                children: [
                                  imageViewerWidget(
                                      imageUrl: repository['thumbnail'],
                                      bestValue: true),
                                  infoViewerWidget(
                                      title: repository['title'],
                                      description: repository['description'],
                                      duration: repository['durationText'],
                                      loyalityPonit:
                                          repository['loyaltyPointText'])
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
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Row(
                                children: [
                                  amenitiesViewerWidget(
                                      amenities: repository['amenities']),
                                  Spacer(),
                                  priceViewingWidget(
                                      price: repository['startingPrice'])
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
                });
          },
        ));
  }

  Widget imageViewerWidget(
      {required String imageUrl, required bool bestValue}) {
    return Container(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
            ),
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.2,
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
                      style: TextStyle(color: COLOR_MARINE_BLUE, fontSize: 11),
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
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.2,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: COLOR_MARINE_BLUE,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          Spacer(),
          Text(
            description,
            style: TextStyle(color: COLOR_BLACK, fontSize: 14),
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
                style: TextStyle(color: COLOR_MARINE_BLUE, fontSize: 16),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              // Icon(Icons.calendar_today,color: COLOR_MARINE_BLUE,),
              Image.asset(
                ICON_FLIGHT,
                height: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                loyalityPonit,
                style: TextStyle(color: COLOR_MARINE_BLUE, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget amenitiesViewerWidget({required List<dynamic> amenities}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.only(top: 5, left: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Includes:",
            style: TextStyle(
              color: COLOR_SUN_FLOWER,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.03,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, ind) {
                return Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.all(3),
                  child: SvgPicture.network(amenities[ind]['icon'],
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
      padding: EdgeInsets.only(
        top: 5,
        right: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Starts from",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "৳ ${price}",
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
