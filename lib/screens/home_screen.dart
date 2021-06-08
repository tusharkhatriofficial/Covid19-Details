import 'dart:convert';
import 'package:covid_developersonline/Error%20Screens/error_screen_1.dart';
import 'package:covid_developersonline/screens/info_screen.dart';
import 'package:covid_developersonline/screens/search_screen.dart';
import 'package:covid_developersonline/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:covid_developersonline/Constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen({key, this.countryData});
  final countryData;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RewardedAd rewardedAd;
  var country;
  var flag;
  var continent;
  var cases;
  var deaths;
  var recovered;
  var infected;
  var deathsToday;
  var recoveredToday;
  var infectedToday;
  var formatted;
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.countryData);
    formatted = Date();

  }

  Future<dynamic> getSearchCountryData(String countryNameInput) async {
    final response = await http.get(Uri.parse(
        "https://corona.lmao.ninja/v3/covid-19/countries/$countryNameInput"));
    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const ErrorScreen1();
      }));
    }
  }

  String Date() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  void updateUI(dynamic countryData) {
    setState(() {
      if (countryData == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ErrorScreen1();
        }));
        // print("Data is null");
        //navigator push error screen
      } else {
        flag = jsonDecode(countryData)['countryInfo']['flag'];
        country = jsonDecode(countryData)['country'];
        continent = jsonDecode(countryData)['continent'];
        deaths = jsonDecode(countryData)['deaths'];
        recovered = jsonDecode(countryData)['recovered'];
        infected = jsonDecode(countryData)['cases'];
        deathsToday = jsonDecode(countryData)['todayDeaths'];
        recoveredToday = jsonDecode(countryData)['todayRecovered'];
        infectedToday = jsonDecode(countryData)['todayCases'];
        // print(continent);
        // print(deaths);
        // print(recovered);
        // print(todayRecovered);
      }
    });
  }

  void loadVideoAd() async {
    rewardedAd = await RewardedAd(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      listener: AdListener(
          onAdLoaded: (Ad ad){
            rewardedAd.show();
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) => Navigator.push(context, MaterialPageRoute(builder: (context){
            return ErrorScreen1();
          })),
          onAdOpened: (Ad ad) => print('Ad Opened'),
          onAdClosed: (Ad ad) => print('Ad Closed'),
          onApplicationExit: (Ad ad) => print('Left application'),
          onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward){
            print('Reward earned: $reward');
          }
      ),
    );
    rewardedAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need is",
              textBottom: "stay at home.",
              offset: offset,
            ),
            GestureDetector(
              onTap: () async {
                var countryNameInput = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SearchScreen();
                }));
                if (countryNameInput != null) {
                  var data = await getSearchCountryData(countryNameInput);
                  updateUI(data);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ErrorScreen1();
                  }));
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xFFE5E5E5),
                    )),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: NetworkImage('$flag'),
                        width: 20,
                      ),
                      Text(
                        '$country',
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: 'Case Update\n', style: kTitleTextstyle),
                            TextSpan(
                              text: 'Newest Update $formatted',
                              style: TextStyle(color: kTextLightColor),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          loadVideoAd();
                        },
                        child: Text(
                          'Watch Ad',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Counter(
                                color: kInfectedColor,
                                number: '$infected',
                                title: 'Infected',
                              ),
                            ), //This is the extracted widget
                            Expanded(
                              child: Counter(
                                color: kDeathColor,
                                number: '$deaths',
                                title: 'Deaths',
                              ),
                            ), //This is the extracted widget
                            Expanded(
                              child: Counter(
                                color: kRecovercolor,
                                number: '$recovered',
                                title: 'Recovered',
                              ),
                            ), //This is the extracted widget
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Counter(
                                color: kInfectedColor,
                                number: '$infectedToday',
                                title: 'Today',
                              ),
                            ), //This is the extracted widget
                            Expanded(
                              child: Counter(
                                color: kDeathColor,
                                number: '$deathsToday',
                                title: 'Today',
                              ),
                            ), //This is the extracted widget
                            Expanded(
                              child: Counter(
                                color: kRecovercolor,
                                number: '$recoveredToday',
                                title: 'Today',
                              ),
                            ), //This is the extracted widget
                          ],
                        ),
                      ],
                    ),
                  ),
                  //here
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InfoScreen();
                }));
              },
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Get to know about covid19',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String number;
  final Color color;
  final String title;

  const Counter({
    Key? key,
    required this.number,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: color, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          number,
          style: TextStyle(fontSize: 10, color: kInfectedColor),
        ),
        Text(
          title,
          style: kSubTextStyle,
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
