import 'package:flutter/material.dart';
class Card1 extends StatelessWidget {
  final int cardIndex;
  final List<Map<String, Object>> cardData;

  Card1({required this.cardData, required this.cardIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      height: 600,
      width: 350,
      decoration: new BoxDecoration(
          color: Colors.greenAccent, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              cardData[cardIndex]['subheading'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: "Source Sans Pro",
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset(cardData[cardIndex]['photo'] as String),
            height: 200,
            width: 200,
          ),
          ...(cardData[cardIndex]['pointers'] as List<Map<String, Object>>)
              .map((pointers) {
            return Text(
              pointers['text'] as String,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Roboto",
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
