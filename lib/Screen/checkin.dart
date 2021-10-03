import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covid_19/Global/globals.dart' as globals;
class checkin extends StatefulWidget {
  @override
  _checkinState createState() => _checkinState();
}

class _checkinState extends State<checkin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent.withOpacity(0.6),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              margin: const EdgeInsets.only(left:5, right: 5),
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "How you feeling today?",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 38,
                            fontWeight: FontWeight.w800)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          child: Card(
                            elevation: 3,
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.white,
                              onTap: () { },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "😁",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 38,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Good",
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
                          width: 150,
                          height: 150,
                          child: Card(
                            elevation: 3,
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              splashColor: Colors.red,
                              onTap: () { },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "😩",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 38,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Not well",
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
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How people feel in",
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                  Text(
                    "🌍 " + globals.adminstative_area,
                    style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w800)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 180,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              // splashColor: Colors.greenAccent,
                              // onTap: () { },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "😁",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 38,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "242",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w800)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Feeling well",
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
                          width: 150,
                          height: 180,
                          child: Card(
                            elevation: 3,
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              // splashColor: Colors.greenAccent,
                              // onTap: () { },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "😩",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 38,
                                              fontWeight:
                                              FontWeight.w500)),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "42",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight:
                                              FontWeight.w800)),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Not well",
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Recovered in " + globals.adminstative_area + " today: " + globals.g_todayRecovered,
                      style: GoogleFonts.lato(
                          textStyle:  const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w500)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Recovered in " + globals.adminstative_area + ": " + globals.g_recovered,
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                              fontWeight:
                              FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
