import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

    class Schedule extends StatefulWidget {
      const Schedule({super.key});

      @override
      State<Schedule> createState() => _ScheduleState();
    }

    class _ScheduleState extends State<Schedule> {
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
                          const SizedBox(height: 20),
                          Text('You have 568 minutes of learning.',
                              style: GoogleFonts.figtree(
                                fontSize: 32,
                                color: Colors.black,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                              )),
                          const SizedBox(height: 80),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xff009966)),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text('1 week',
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Colors.white,
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xff009966)),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text('2 weeks',
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Colors.white,
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width:393,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (const Color(0xff009966)),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              ),
                              child: Text('4 weeks',
                                  style: GoogleFonts.figtree(
                                    fontSize: 24,
                                    color: Colors.white,
                                    height: 0.8,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(

                              children: [
                                Container(
                                  width:185,
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      print('test');
                                      String eventName = 'Recurring Event';
                                      String eventDescription = 'Description of recurring event';
                                      DateTime eventStartDate = DateTime.now().add(const Duration(days: 1));
                                      DateTime eventEndDate = eventStartDate.add(const Duration(hours: 2));
                                      String formattedStartDate = eventStartDate.toUtc().toIso8601String();
                                      String formattedEndDate = eventEndDate.toUtc().toIso8601String();
                                      String recurrenceRule = 'RRULE:FREQ=WEEKLY;BYDAY=MO,WE';
                                      String googleCalendarUrl =
                                          'https://www.google.com/calendar/render?action=TEMPLATE&text=$eventName&dates=$formattedStartDate/$formattedEndDate&details=$eventDescription&$recurrenceRule';
                                      print(Uri.parse(googleCalendarUrl));
                                      if (!await launchUrl(Uri.parse(googleCalendarUrl))) {
                                      throw Exception('Could not launch url');
                                      }


                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (const Color(0xff009966)),
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                    ),
                                    child: Text('Keep Me On Track!',
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
                                  padding: const EdgeInsets.only(left: 10.0),
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
                                        Text('Skip',
                                            style: GoogleFonts.figtree(
                                              fontSize: 26,
                                              color: Colors.white,
                                              height: 0.8,
                                              fontWeight: FontWeight.w800,
                                            )),
                                        const Icon(Icons.arrow_forward_ios_rounded,
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
