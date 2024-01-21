import 'dart:math';

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

    class Schedule extends StatefulWidget {
      const Schedule({super.key});

      @override
      State<Schedule> createState() => _ScheduleState();
    }

    class _ScheduleState extends State<Schedule> {
      int weeks = 0;
      bool submitState = false;
      bool stateOne = false;
      bool stateTwo = false;
      bool stateFour = false;
      int minutes = 56;
      @override
      Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 250,
                                child: Text('Pace yourself for success!',
                                    style: GoogleFonts.figtree(
                                      fontSize: 32,
                                      color: Colors.black,
                                      height: 1.15,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                              const Image(
                                image: AssetImage('assets/logo.png'),
                                height: 70,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('You have $minutes minutes of learning.',
                              style: GoogleFonts.figtree(
                                fontSize: 32,
                                color: Colors.black,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                              )),
                          SizedBox(height: 80),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: (){
                                weeks = 1;
                                submitState = true;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xffffffff)),
                                elevation: 0.0,
                                side: BorderSide(color: Color(0xff009966), width: 4.0),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text("1 week",
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Color(0xff009966),
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: (){
                                weeks = 2;
                                submitState = true;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xffffffff)),
                                elevation: 0.0,
                                side: BorderSide(color: Color(0xff009966), width: 4.0),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text("2 weeks",
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Color(0xff009966),
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: (){
                                weeks = 4;
                                submitState = true;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xffffffff)),
                                elevation: 0.0,
                                side: BorderSide(color: Color(0xff009966), width: 4.0),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text("4 weeks",
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Color(0xff009966),
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(

                              children: [
                                Container(
                                  width:185,
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (submitState){
                                      print('test');
                                      int i = 1;
                                      double per = minutes.toDouble();
                                      while (i<=5 && per >15){
                                        per = minutes/(i*weeks);
                                        i++;
                                      }
                                      double higher = ((minutes/((i+1)*weeks))-15).abs();
                                      double lower = ((minutes/(i*weeks))-15).abs();
                                      if (min(lower, higher) == lower) {
                                        i = i;
                                      }
                                      else {
                                        i++;
                                      }
                                      int timesaWeek = i;
                                      double minutesEach = minutes/(i*weeks);
                                      int calMinutes = minutesEach.ceil();
                                      print (timesaWeek);
                                      print(minutesEach);
                                      String eventName = 'The History of China ($calMinutes minutes)';
                                      String eventDescription = 'Open the Learndeck App and start learning!';
                                      DateTime eventStartDate = DateTime.now();
                                      DateTime eventEndDate = eventStartDate.add(Duration(minutes: (minutesEach.toInt())));
                                      String formattedStartDate = eventStartDate.toUtc().toIso8601String();
                                      String formattedEndDate = eventEndDate.toUtc().toIso8601String();
                                      String recurrenceRule = 'recur=RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR;INTERVAL=1';
                                      String googleCalendarUrl =
                                          'https://www.google.com/calendar/render?action=TEMPLATE&text=$eventName&dates=$formattedStartDate/$formattedEndDate&details=$eventDescription&$recurrenceRule';
                                      print(Uri.parse(googleCalendarUrl));
                                      if (!await launchUrl(Uri.parse(googleCalendarUrl, ), mode: LaunchMode.externalApplication)) {
                                      throw Exception('Could not launch url');
                                      }
                                    }
                                      else {
                                        null;
                                      }
      },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (const Color(0xff009966)),
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                    child: Text("Keep Me On Track!",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.figtree(
                                          fontSize: 26,
                                          color: Colors.white,
                                          height: 0.8,
                                          fontWeight: FontWeight.w800,
                                        )),
                                  ),
                                ),
                                Container(
                                  width: 145,
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (const Color(0xff009966)),
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Skip",
                                            style: GoogleFonts.figtree(
                                              fontSize: 26,
                                              color: Colors.white,
                                              height: 0.8,
                                              fontWeight: FontWeight.w800,
                                            )),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ])),
              ),
            ));
      }
    }
