import 'package:covid_19/Screen/homepage.dart';
import 'package:covid_19/Screen/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: landingpage(),
      builder: EasyLoading.init(),
    );
  }
}