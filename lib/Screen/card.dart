import 'package:flutter/material.dart';
class Card1 extends StatelessWidget {
  final int cardIndex;
  final List<Map<String, Object>> cardData;

  Card1({required this.cardData, required this.cardIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      height: 600,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.greenAccent, borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              cardData[cardIndex]['subheading'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: "Source Sans Pro",
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Image.asset(cardData[cardIndex]['photo'] as String),
            height: 200,
            width: 200,
          ),
          ...(cardData[cardIndex]['pointers'] as List<Map<String, Object>>)
              .map((pointers) {
            return Container(
              padding: const EdgeInsets.only(left: 20, top: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  pointers['text'] as String,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
