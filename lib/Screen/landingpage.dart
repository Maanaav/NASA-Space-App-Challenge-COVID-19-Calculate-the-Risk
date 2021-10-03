import 'package:covid_19/Screen/checkin.dart';
import 'package:covid_19/Screen/global.dart';
import 'package:covid_19/Screen/homepage.dart';
import 'package:covid_19/Screen/lockdown.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covid_19/Global/globals.dart' as globals;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class landingpage extends StatefulWidget {
  @override
  _landingpageState createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {

  String stringResponse = '';
  late Map mapResponse;
  late Map dataResponse;
  late List listResponse;
  var listlen = 0;

  late String states;
  late String active;
  late String death;
  late String recovered;
  late String cases;

  late String todayActive;
  late String todayRecovered;
  late String todayDeaths;
  late String todayCases;

  final children = <Widget>[];

  // -----------

  String stringResponseCov = '';
  late Map mapResponseCov;
  late Map dataResponseCov;
  late List listResponseCov;
  var listlenCov = 0;

  late String stringResponseWeather;
  late Map mapResponseWeather;
  late List listResponseWeather;
  var listlenWeather;
  var aqiScore;
  late String aqiStatus;
  var tempC;

  late String stringResponseGlobal;
  late Map listResponseGlobal;

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/gov/${globals.country}"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['states'];
        listlen = listResponse.length;
      });

      for (int i = 0; i < listlen; i++) {
        if (listResponse[i]['state'] == globals.adminstative_area) {
          states = listResponse[i]['state'].toString();

          active = listResponse[i]['active'].toString();
          death = listResponse[i]['death'].toString();
          recovered = listResponse[i]['recovered'].toString();
          cases = listResponse[i]['cases'].toString();

          todayActive = listResponse[i]['todayActive'].toString();
          todayDeaths = listResponse[i]['todayDeaths'].toString();
          todayRecovered = listResponse[i]['todayRecovered'].toString();
          todayCases = listResponse[i]['todayCases'].toString();
        }
      }

      setState(() {
        globals.g_states = states;

        globals.g_active = active;
        globals.g_death = death;
        globals.g_recovered = recovered;
        globals.g_cases = cases;

        globals.g_todayActive = todayActive;
        globals.g_todayDeaths = todayDeaths;
        globals.g_todayRecovered = todayRecovered;
        globals.g_todayCases = todayCases;
      });

      // ----------

      http.Response responseWeather;
      responseWeather = await http.get(Uri.parse(
          "https://api.airvisual.com/v2/city?city=${globals.locality}&state=${globals.adminstative_area}&country=${globals.country}&key=89a7a667-20e5-42dd-9ed8-195048b1a885"));
      if (responseWeather.statusCode == 200) {
        setState(() {
          stringResponseWeather = responseWeather.body;
          mapResponseWeather = json.decode(responseWeather.body);
          aqiScore = mapResponseWeather["data"]["current"]["pollution"]["aqius"];
          tempC = mapResponseWeather["data"]["current"]["weather"]["tp"];

          if (aqiScore <= 0 || aqiScore <= 50) {
            aqiStatus = "Good";
          } else if (aqiScore <= 51 || aqiScore <= 100) {
            aqiStatus = "Moderate";
          } else if (aqiScore <= 101 || aqiScore <= 150) {
            aqiStatus = "Fine";
          } else if (aqiScore <= 151 || aqiScore <= 200) {
            aqiStatus = "Unhealthy";
          } else if (aqiScore <= 201 || aqiScore <= 300) {
            aqiStatus = "Very Unhealthy";
          } else if (aqiScore <= 301 || aqiScore <= 500) {
            aqiStatus = "Hazardous";
          }

          globals.g_aqiScore = aqiScore;
          globals.g_tempC = tempC;
          globals.g_aqiStatus = aqiStatus;
        });
      }

      // --------------

      http.Response responseGlobal;
      responseGlobal =
      await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));
      if (responseGlobal.statusCode == 200) {
        setState(() {
          stringResponseGlobal = responseGlobal.body;
          listResponseGlobal = json.decode(responseGlobal.body);

          globals.g_globalcases = listResponseGlobal['cases'];
          globals.g_globalactive = listResponseGlobal['active'];
          globals.g_globaldeath = listResponseGlobal['deaths'];
          globals.g_globalrecovered = listResponseGlobal['recovered'];
        });
      }

    }
  }

  // ----------------------------

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  void get_location() async{
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    globals.lat = double.parse("${position.latitude}");
    globals.long = double.parse("${position.longitude}");

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark placeMark = placemarks[0];

      globals.adminstative_area = placeMark.administrativeArea;
      globals.country = placeMark.country;
      globals.locality = placeMark.locality;

      print(placeMark.administrativeArea);
      print(placeMark.country);

      apicall();
    }catch(err){}
  }

  void initState() {
    super.initState();
    get_location();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent.withOpacity(0.1),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            // Container(
            //   height: 40,
            //   margin: const EdgeInsets.only(bottom: 10),
            //   color: Colors.black87,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.only(right: 50, left: 30, top:15),
              child: globals.locality != null ? Text(
                "🌎 " + globals.locality,
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600)),
              ) : Text(""),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: const EdgeInsets.only(right: 50, left: 30,),
              child: Text(
                "Good " + greeting() + ",",
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: 140,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {
                              print("Yes");
                            },
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: OverflowBox(
                                      minHeight: MediaQuery.of(context).size.width / 2.3,
                                      maxHeight: MediaQuery.of(context).size.width / 2.3,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          "assets/covid.png",
                                          height: 200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 5,
                                      bottom: 20),
                                  margin: const EdgeInsets.only(top: 30),
                                  child: ListTile(
                                    title: Align(
                                        alignment: Alignment
                                            .topLeft,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 2.2,
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "How to recover from COVID 19",
                                            style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight:
                                                    FontWeight.w800)),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                )),
            Container(
              height: MediaQuery.of(context).size.height - 60 - 140 - 90 - 50,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          height: 200,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.greenAccent,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => checkin()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/checkIn.png", height: 130),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Check In",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top:30),
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          height: 200,
                          child: Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.greenAccent,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/riskZone.png", height: 130),
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "Risk Zone",
                                        style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.w500)),
                                      ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          height: 200,
                          child: Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.greenAccent,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => global()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/Global.png", height: 130),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Global",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:30),
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          height: 200,
                          child: Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.greenAccent,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => lockdown()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/globalStats.png", height: 130),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Lockdown",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
