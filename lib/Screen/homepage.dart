import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:covid_19/Global/globals.dart' as globals;
import 'package:rflutter_alert/rflutter_alert.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // List demo = [];


  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }

  var myNumber;

  void initState(){
    super.initState();
    myNumber = k_m_b_generator(int.parse(globals.g_active));
  }

  late GoogleMapController _mapController;

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(37.0902, 95.7129), zoom: 2.5);

  void _onMapcreated(GoogleMapController _ctrl) {
    changeMapMode();
    _mapController = _ctrl;

    _mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(globals.lat, globals.long), zoom: 15)));
  }

  changeMapMode() {
    getJsonFile("assets/dark.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _mapController.setMapStyle(mapStyle);
  }

  // --------------------------------------

  double _pinPill = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: _onMapcreated,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onTap: (coordinate) {
              _mapController.animateCamera(CameraUpdate.newLatLng(coordinate));
              setState(() {
                _pinPill = 0;
              });
            },
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _pinPill = 1;
                });
              },
              child: AnimatedContainer(
                padding: const EdgeInsets.all(5),
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width: MediaQuery.of(context).size.width,
                height: _pinPill == 0
                    ? MediaQuery.of(context).size.height / 4.8
                    : MediaQuery.of(context).size.height / 3.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 20,
                          offset: Offset.zero,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        Text(myNumber, style: TextStyle(fontSize: 34),),
                                        Text("😷 Active", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                                      ],)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        Text(globals.g_tempC.toString() + "°C", style: TextStyle(fontSize: 34),),
                                        Text("🌡 Temp", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                                      ],)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        Text(globals.g_aqiScore.toString(), style: TextStyle(fontSize: 34),),
                                        Text("💨 ${globals.g_aqiStatus.toString()}", style: TextStyle(color: Colors.black.withOpacity(0.7)),),
                                      ],)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _pinPill == 0 ?
                                Container(
                                child: ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () {
                                    setState(() {
                                      _pinPill = 1;
                                    });
                                  },
                                  child: const Text('Know more?'),
                                )
                              ) : Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Text("Today active cases: "+ globals.g_todayCases),
                                      Text("Today recovered: " + globals.g_todayRecovered),
                                      Text("Today death: " + globals.g_todayDeaths),

                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: ElevatedButton(
                                          style: raisedButtonStyle,
                                          onPressed: () {
                                            Alert(
                                              context: context,
                                              // type: AlertType.error,
                                              title: "Mask suggestions",
                                              image: globals.g_maskType == "Cloth mask" ? Image.asset("assets/cloth.png") :
                                              globals.g_maskType == "Surgical mask" ? Image.asset("assets/surgical.png") :
                                              Image.asset("assets/kn95.png"),
                                              desc: "It is ${globals.g_safe} to go out, \n We suggest you to wear ${globals.g_maskType} in ${globals.adminstative_area}",
                                              buttons: [
                                                DialogButton(
                                                  gradient: const LinearGradient(colors: [
                                                    Color.fromRGBO(0, 0, 0, 1.0),
                                                    Color.fromRGBO(0, 0, 0, 1.0)
                                                  ]),
                                                  child: const Text("COOL", style: TextStyle(color: Colors.white, fontSize: 20),),
                                                  onPressed: () => Navigator.pop(context),
                                                  width: 120,
                                                )
                                              ],
                                            ).show();
                                          },
                                          child: const Text('Get safe >'),
                                        ),
                                      ),
                                    ],
                                  ),

                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  primary: Colors.black,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);