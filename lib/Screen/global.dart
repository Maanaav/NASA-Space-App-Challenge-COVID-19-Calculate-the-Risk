import 'package:covid_19/Global/globals.dart' as globals;
import 'package:flutter/material.dart';

class global extends StatefulWidget {
  @override
  _globalState createState() => _globalState();
}

class _globalState extends State<global> {

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
    myNumber = k_m_b_generator((globals.g_globalcases));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Container(
        color: Color.fromRGBO(245,247,248,100),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(myNumber.toString(), style: TextStyle(fontSize: 80),),
            Text("😷  Global Active Cases", style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20),),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Image.asset("assets/earth.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
