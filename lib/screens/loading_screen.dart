import 'dart:convert';
import 'package:covid_developersonline/screens/home_screen.dart';
import 'package:covid_developersonline/Error%20Screens/error_screen_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final bool _showSpinner = true;
  var locationCountry;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //TODO init state
    getCountryName();
  }

  // This method fetches the country name !!
  final urlForCountry = "http://ip-api.com/json";
   getCountryName() async {
     try {
       final response = await http.get(Uri.parse(urlForCountry));
       if (response.statusCode == 200) {
         String data = response.body;
         final countryName = json.decode(data)['country'];
         locationCountry = countryName;
         getCountryData(locationCountry);
       }
     }catch(e){
       Navigator.push(context, MaterialPageRoute(builder: (context) {
         return const ErrorScreen1();
       }));
     }
  }


  getCountryData(String locationCountry) async {

      final response = await http.get(Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries/$locationCountry"));
      if (response.statusCode == 200){
        var data = response.body;
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return  HomeScreen(
              countryData: data,
          );
        }));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const ErrorScreen1();
        }));
      }

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitCircle(
        color: Color(0xFF11249F),
        size: 50.0,
      ),
    );
  }
}
