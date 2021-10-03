import 'package:covid_19/Screen/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covid_19/Global/globals.dart' as globals;

class guidelines extends StatefulWidget {
  @override
  _guidelinesState createState() => _guidelinesState();
}

class _guidelinesState extends State<guidelines> {
  var cardIndex = 0;
  final _pointer = const [
    {
      'photo': 'assets/prr.png',
      'subheading': 'Precautions',
      'pointers': [
        {'text': 'Wear a mask'},
        {'text': 'Clean your hands'},
        {'text': 'Maintain safe distance'},
        {'text': 'Get vaccinated'},
        {'text': 'Stay home if you feel unwell'},
        {'text': 'Follow local guidance'},
        {'text': 'Avoid crowded places'},
        {'text': 'Avoid touching surface'},
        {'text': 'Cover your coughs and sneeze'},
        {'text': 'Keep good hygiene'},
        {'text': 'Stay in well ventilated areas'}
      ],
    },
    {
      'photo': 'assets/plane.png',
      'subheading': 'Travel',
      'pointers': [
        {'text': 'Wear a mask'},
        {'text': 'Follow all state and local recommendationss'},
        {'text': 'Self-monitor for COVID-19 symptoms'},
        {'text': 'Get tested with a viral test 1-3 days before your trip'},
        {'text': 'Avoid travel to high risk countries'},
        {'text': 'Avoid touching surface'},
        {'text': 'Avoid crowded places'},
        {'text': 'Avoid touching surface'},
        {'text': 'Travel with vaccine certificate'},
        {'text': 'Maintain physical distance of at least 1 metre'},
        {'text': 'Plan your travel'}
      ],
    },
    {
      'photo': 'assets/symptoms.png',
      'subheading': 'Symptomatic',
      'pointers': [
        {'text': 'Answer questions to determine your risk'},
        {'text': 'Follow your health care provider\’s instructions'},
        {'text': 'Practice hand hygiene and respiratory etiquette'},
        {'text': 'Stay calm'},
        {'text': 'Consider being vaccinated for COVID-19'}
      ],
    },
    {
      'photo': 'assets/mask.png',
      'subheading': 'Mask Tips',
      'pointers': [
        {'text': 'Medical masks are recommended for'},
        {'text': 'Health workers'},
        {'text': 'Symptomatic individuals'},
        {'text': 'People caring for someone with high risk'},
        {'text': 'People aged 60 or over'},
        {'text': 'People of any age with underlying health conditions'},
        {'text': 'Non-medical, fabric masks are recommended for'},
        {
          'text':
          'General public under the age of 60 and who do not have underlying health conditions.'
        }
      ],
    },
  ];
  void goRight() {
    setState(() {
      cardIndex++;
    });
  }

  void goLeft() {
    setState(() {
      cardIndex--;
    });
  }

  void goLast() {
    setState(() {
      cardIndex = 3;
    });
  }

  void goFirst() {
    setState(() {
      cardIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guidelines',
      home: Scaffold(
        body: Column(
          children: [
            // title - guidelines
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 40),
              child: Text(
                'GUIDELINES',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900),
              ),
            ),
            Card1(cardData: _pointer, cardIndex: cardIndex),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: new Icon(Icons.arrow_left_outlined, size: 60.0),
                  onPressed: cardIndex > 0 ? goLeft : goLast,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: new Icon(Icons.arrow_right_outlined, size: 60.0),
                  onPressed: cardIndex < 3 ? goRight : goFirst,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
